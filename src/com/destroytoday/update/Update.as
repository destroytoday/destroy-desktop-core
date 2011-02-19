package com.destroytoday.update
{
	public class Update implements IUpdate
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _descriptor:XML;
		
		protected var _version:IVersion;
		
		protected var _date:Date;
		
		protected var _url:String;
		
		protected var _description:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function Update(descriptor:XML)
		{
			_descriptor = descriptor;
			
			verify();
			populate();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get version():IVersion
		{
			return _version;
		}
		
		public function get date():Date
		{
			return _date;
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function get description():String
		{
			return _description;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function verify():void
		{
			if (!_descriptor)
				throw new Error("'descriptor' is required.");
			
			var ns:Namespace = _descriptor.namespace();
			var version:String = 
				_descriptor.ns::versionLabel ||
				_descriptor.ns::versionNumber ||
				_descriptor.ns::version;
			var date:String = _descriptor.ns::date;
			var url:String = _descriptor.ns::url;
			var description:String = _descriptor.ns::description;
			
			if (!version)
				throw new Error("'version' is missing.");
			
			if (!date)
				throw new Error("'date' is missing.");
			
			if (!url)
				throw new Error("'date' is missing.");
			
			if (!description)
				throw new Error("'description' is missing.");
		}
		
		protected function populate():void
		{
			var ns:Namespace = _descriptor.namespace();
			var version:String = 
				_descriptor.ns::versionLabel ||
				_descriptor.ns::versionNumber ||
				_descriptor.ns::version;
			
			_version = new Version(version);
			_date = new Date(String(_descriptor.ns::date));
			_url = _descriptor.ns::url;
			_description = _descriptor.ns::description;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function toString():String
		{
			return String(_descriptor);
		}
	}
}