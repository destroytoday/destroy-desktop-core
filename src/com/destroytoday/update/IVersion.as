package com.destroytoday.update
{
	import com.destroytoday.model.enum.IVersionType;

	public interface IVersion
	{
		function get major():int;
		function get minor():int;
		function get patch():int;
		function get type():IVersionType;
		function get special():int;
		
		function isNewerThan(version:IVersion):Boolean;
		function toString():String;
	}
}