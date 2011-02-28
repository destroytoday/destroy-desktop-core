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
	import com.destroytoday.model.enum.IVersionType;
	import com.destroytoday.model.enum.VersionType;

	public class Version implements IVersion
	{
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		protected static const regex:RegExp = /^([0-9]+)\.([0-9]+)\.([0-9]+)(?:(a|b|rc)([0-9]*))?$/;
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _version:String;
		
		protected var _major:int;
		
		protected var _minor:int;
		
		protected var _patch:int;
		
		protected var _type:IVersionType;
		
		protected var _special:int;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function Version(version:String)
		{
			_version = version;
			
			verify();
			populate();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get major():int
		{
			return _major;
		}
		
		public function get minor():int
		{
			return _minor;
		}
		
		public function get patch():int
		{
			return _patch;
		}
		
		public function get type():IVersionType
		{
			return _type;
		}
		
		public function get special():int
		{
			return _special;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function verify():void
		{
			if (!regex.test(_version))
				throw new Error("Version " + _version + " is invalid.");
		}
		
		protected function populate():void
		{
			var partList:Array = _version.match(regex);
			
			_major = int(partList[1]);
			_minor = int(partList[2]);
			_patch = int(partList[3]);
			_type = VersionType.getByAbbrev(partList[4]);
			_special = int(partList[5]);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function isNewerThan(version:IVersion):Boolean
		{
			return (
				_major > version.major || 
				_minor > version.minor || 
				_patch > version.patch || 
				_type.priority > version.type.priority || 
				_special > version.special
			);
		}
		
		public function toString():String
		{
			return _version;
		}
	}
}