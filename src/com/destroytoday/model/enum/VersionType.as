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