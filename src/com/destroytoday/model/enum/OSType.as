package com.destroytoday.model.enum
{
	public class OSType
	{
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		public static const MAC:OSType = new OSType("Mac");
		
		public static const WINDOWS:OSType = new OSType("Windows");
		
		public static const LINUX:OSType = new OSType("Linux");

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
		
		public function OSType(name:String)
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