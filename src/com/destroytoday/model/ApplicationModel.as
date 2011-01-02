package com.destroytoday.model
{
	import com.destroytoday.update.Version;
	
	import flash.desktop.NativeApplication;
	
	public class ApplicationModel implements IApplicationModel
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _descriptor:XML;
		
		protected var _id:String;
		
		protected var _name:String;
		
		protected var _filename:String;
		
		protected var _version:Version;
		
		protected var _url:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ApplicationModel()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get descriptor():XML
		{
			if (!_descriptor)
			{
				descriptor = NativeApplication.nativeApplication.applicationDescriptor;
			}
			
			return _descriptor;
		}
		
		public function set descriptor(value:XML):void
		{
			_descriptor = value;
		}
		
		public function get id():String
		{
			if (!_id)
			{
				var descriptor:XML = descriptor;
				var ns:Namespace = descriptor.namespace();
				
				id = descriptor.ns::id;
			}
			
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		public function get name():String
		{
			if (!_name)
			{
				var descriptor:XML = descriptor;
				var ns:Namespace = descriptor.namespace();
				
				name = descriptor.ns::name;
			}
			
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function get filename():String
		{
			if (!_filename)
			{
				var descriptor:XML = descriptor;
				var ns:Namespace = descriptor.namespace();
				
				filename = descriptor.ns::filename;
			}
			
			return _filename;
		}
		
		public function set filename(value:String):void
		{
			_filename = value;
		}
		
		public function get version():Version
		{
			if (!_version)
			{
				var descriptor:XML = descriptor;
				var ns:Namespace = descriptor.namespace();
				var version:String = 
					descriptor.ns::versionLabel ||
					descriptor.ns::versionNumber ||
					descriptor.ns::version;
				
				this.version = new Version(version);
			}
			
			return _version;
		}
		
		public function set version(value:Version):void
		{
			_version = value;
		}
		
		public function get url():String
		{
			if (!_url)
			{
				var descriptor:XML = descriptor;
				var ns:Namespace = descriptor.namespace();
				
				url = descriptor.ns::url;
			}
			
			return _url;
		}
		
		public function set url(value:String):void
		{
			_url = value;
		}
	}
}