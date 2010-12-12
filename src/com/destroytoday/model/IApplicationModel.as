package com.destroytoday.model
{
	import com.destroytoday.update.Version;

	public interface IApplicationModel
	{
		function get id():String;
		
		function get name():String;

		function get filename():String;
		
		function get version():Version;
	}
}