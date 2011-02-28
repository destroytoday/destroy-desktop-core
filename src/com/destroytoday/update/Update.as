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