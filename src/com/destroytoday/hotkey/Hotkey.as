package com.destroytoday.hotkey
{
	import flash.ui.Keyboard;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class Hotkey
	{
		//--------------------------------------------------------------------------
		//
		//  Signals
		//
		//--------------------------------------------------------------------------
		
		protected var _executed:Signal;
		
		public function get executed():Signal
		{
			return _executed ||= new Signal();
		}
		
		public function set executed(value:Signal):void
		{
			if (value == _executed) return;
			
			_executed = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _key:String;
		
		protected var _keyCode:int = -1;

		protected var _modifierList:Array;
		
		protected var _osList:Array;
		
		protected var _enabled:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function Hotkey(keyOrKeyCode:*, modifierList:Array = null, osList:Array = null)
		{
			 if (keyOrKeyCode is String)
			{
				key = keyOrKeyCode;
			}
			 else if (keyOrKeyCode is uint)
			{
				keyCode = keyOrKeyCode;
			}
			 else
			 {
				 throw new ArgumentError("keyOrKeyCode must be of type uint or string");
			 }
			
			this.modifierList = modifierList;
			this.osList = osList;
		}

		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get key():String
		{
			return _key;
		}
		
		public function set key(value:String):void
		{
			_keyCode = -1;
			_key = value;
		}
		
		public function get keyCode():int
		{
			return _keyCode;
		}
		
		public function set keyCode(value:int):void
		{
			_key = null;
			_keyCode = value;
		}
		
		public function get modifierList():Array
		{
			return _modifierList;
		}
		
		public function set modifierList(value:Array):void
		{
			if (value == _modifierList) return;
			
			_modifierList = value;
			
			if (_modifierList)
				_modifierList.sort();
		}
		
		public function get osList():Array
		{
			return _osList;
		}
		
		public function set osList(value:Array):void
		{
			if (value == _osList) return;
			
			_osList = value;
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function execute():void
		{
			executed.dispatch();
		}
		
		public function toString():String
		{
			var keyString:String = key || HotkeyManager.getStringFromKeyCode(keyCode);
			
			return (modifierList) ? modifierList.join(' + ') + ' + ' + keyString : keyString;
		}
	}
}