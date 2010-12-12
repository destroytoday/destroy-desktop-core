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
		
		protected var _id:String;
		
		protected var _name:String;
		
		protected var _filename:String;
		
		protected var _version:Version;
		
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
		
		public function get id():String
		{
			if (!_id)
			{
				var descriptor:XML = NativeApplication.nativeApplication.applicationDescriptor;
				var ns:Namespace = descriptor.namespace();
				
				_id = descriptor.ns::id;
			}
			
			return _id;
		}
		
		public function get name():String
		{
			if (!_name)
			{
				var descriptor:XML = NativeApplication.nativeApplication.applicationDescriptor;
				var ns:Namespace = descriptor.namespace();
				
				_name = descriptor.ns::name;
			}
			
			return _name;
		}
		
		public function get filename():String
		{
			if (!_filename)
			{
				var descriptor:XML = NativeApplication.nativeApplication.applicationDescriptor;
				var ns:Namespace = descriptor.namespace();
				
				_filename = descriptor.ns::filename;
			}
			
			return _filename;
		}
		
		public function get version():Version
		{
			if (!_version)
			{
				var descriptor:XML = NativeApplication.nativeApplication.applicationDescriptor;
				var ns:Namespace = descriptor.namespace();
				var version:String = 
					descriptor.ns::versionLabel ||
					descriptor.ns::versionNumber ||
					descriptor.ns::version;
				
				_version = new Version(version);
			}
			
			return _version;
		}
	}
}