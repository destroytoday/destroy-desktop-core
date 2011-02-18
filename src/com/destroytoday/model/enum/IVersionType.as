package com.destroytoday.model.enum
{
	public interface IVersionType
	{
		function get name():String;
		function get abbrev():String;
		function get priority():int;
		
		function toString():String;
	}
}