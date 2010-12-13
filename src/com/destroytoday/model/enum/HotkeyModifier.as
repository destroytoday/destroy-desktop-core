package com.destroytoday.model.enum
{
	import flash.ui.Keyboard;

	public class HotkeyModifier
	{
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		public static const COMMAND:HotkeyModifier = new HotkeyModifier("command", Keyboard.COMMAND);

		public static const CONTROL:HotkeyModifier = new HotkeyModifier("control", Keyboard.CONTROL);

		public static const SHIFT:HotkeyModifier = new HotkeyModifier("shift", Keyboard.SHIFT);
		
		public static const ALTERNATE:HotkeyModifier = new HotkeyModifier("alternate", Keyboard.ALTERNATE);
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _name:String;
		
		protected var _keyCode:uint;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function HotkeyModifier(name:String, keyCode:uint)
		{
			_name = name;
			_keyCode = keyCode;
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
		
		public function get keyCode():uint
		{
			return _keyCode;
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