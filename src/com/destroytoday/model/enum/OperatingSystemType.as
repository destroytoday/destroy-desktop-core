package com.destroytoday.model.enum
{
	public class OperatingSystemType
	{
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		public static const MAC:OperatingSystemType = new OperatingSystemType("Mac");
		
		public static const WINDOWS:OperatingSystemType = new OperatingSystemType("Windows");
		
		public static const LINUX:OperatingSystemType = new OperatingSystemType("Linux");

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _name:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function OperatingSystemType(name:String)
		{
			_name = name;
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