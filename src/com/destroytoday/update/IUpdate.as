package com.destroytoday.update
{
	public interface IUpdate
	{
		function get version():IVersion;
		function get date():Date;
		function get url():String;
		function get description():String;
		
		function toString():String;
	}
}