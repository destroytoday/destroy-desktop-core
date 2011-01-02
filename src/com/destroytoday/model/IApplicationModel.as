package com.destroytoday.model
{
	import com.destroytoday.update.Version;

	public interface IApplicationModel
	{
		function get descriptor():XML;
		function set descriptor(value:XML):void;
		
		function get id():String;
		function set id(value:String):void;
		
		function get name():String;
		function set name(value:String):void;
		
		function get filename():String;
		function set filename(value:String):void;		
		
		function get version():Version;
		function set version(value:Version):void;
		
		function get url():String;
		function set url(value:String):void;
	}
}