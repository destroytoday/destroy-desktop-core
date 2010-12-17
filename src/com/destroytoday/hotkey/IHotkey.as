package com.destroytoday.hotkey
{
	import org.osflash.signals.Signal;

	public interface IHotkey
	{
		function get executed():Signal;
		function set executed(value:Signal):void;
		
		function get enabled():Boolean;
		function set enabled(value:Boolean):void;
		
		function get osTypeList():Array;
		
		function execute():void;
		function toString():String;
	}
}