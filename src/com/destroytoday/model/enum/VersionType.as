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

package com.destroytoday.model.enum
{

	public class VersionType implements IVersionType
	{
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		public static const PUBLIC:VersionType = new VersionType('public', '', 3);

		public static const RELEASE_CANDIDATE:VersionType = new VersionType('release candidate', 'rc', 2);

		public static const BETA:VersionType = new VersionType('beta', 'b', 1);

		public static const ALPHA:VersionType = new VersionType('alpha', 'a', 0);

		//--------------------------------------------------------------------------
		//
		//  Maps
		//
		//--------------------------------------------------------------------------
		
		protected static const nameMap:Object = 
		{ 
			'public': PUBLIC, 
			'release candidate': RELEASE_CANDIDATE, 
			'beta': BETA, 
			'alpha': ALPHA 
		}
			
		protected static const abbrevMap:Object = 
		{ 
			_: PUBLIC, 
			rc: RELEASE_CANDIDATE, 
			b: BETA, 
			a: ALPHA 
		}
		
		protected static const priorityMap:Vector.<VersionType> = new Vector.<VersionType>(
		[
			ALPHA,
			BETA,
			RELEASE_CANDIDATE,
			PUBLIC
		]);
		
		//--------------------------------------------------------------------------
		//
		//  Static Methods
		//
		//--------------------------------------------------------------------------

		public static function getByName(name:String):IVersionType
		{
			return nameMap[name];
		}

		public static function getByAbbrev(abbrev:String):IVersionType
		{
			return abbrevMap[abbrev || '_'];
		}

		public static function getByPriority(priority:int):VersionType
		{
			return priorityMap[priority];
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		protected var _name:String;

		protected var _abbrev:String;

		protected var _priority:int;

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function VersionType(name:String, abbrev:String, priority:int)
		{
			_name = name;
			_abbrev = abbrev;
			_priority = priority;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------

		public function get name():String
		{
			return _name;
		}

		public function get abbrev():String
		{
			return _abbrev;
		}

		public function get priority():int
		{
			return _priority;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------

		public function toString():String
		{
			return _name;
		}
	}
}