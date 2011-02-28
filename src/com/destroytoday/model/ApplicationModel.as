/*
Copyright (c) 2011 Jonnie Hallman

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

package com.destroytoday.model
{
	import com.destroytoday.update.IVersion;
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
		
		protected var _version:IVersion;
		
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

		public function get version():IVersion
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
		
		public function set version(value:IVersion):void
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