package com.destroytoday.hotkey
{
	import com.destroytoday.environment.OS;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.system.IME;
	import flash.ui.Keyboard;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class HotkeyManager
	{
		//--------------------------------------------------------------------------
		//
		//  Signals
		//
		//--------------------------------------------------------------------------
		
		protected var _hotkeyExecuted:Signal;
		
		public function get hotkeyExecuted():Signal
		{
			return _hotkeyExecuted ||= new Signal(Hotkey);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _os:OS;
		
		protected var _stage:Stage;
		
		protected var hotkeyList:Vector.<Hotkey> = new Vector.<Hotkey>();
		
		protected var executingModifierList:Vector.<uint> = new Vector.<uint>();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function HotkeyManager(os:OS, stage:Stage)
		{
			_os = os;
			this.stage = stage;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get stage():Stage
		{
			return _stage;
		}
		
		public function set stage(value:Stage):void
		{
			if (value == _stage) return;
					
			if (_stage)
			{
				_stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			}
			
			_stage = value;
			
			_stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Static Methods
		//
		//--------------------------------------------------------------------------
		
		public static function getStringFromKeyCode(keyCode:uint):String
		{
			var keyString:String;
			
			for (var property:String in Keyboard)
			{
				if (Keyboard[property] == keyCode)
				{
					keyString = '{' + property + '}';
					
					break;
				}
			}
			
			return keyString;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function populateExecutingModifierList(event:KeyboardEvent):void
		{
			executingModifierList.length = 0;
			
			if (event.altKey) executingModifierList.push(Keyboard.ALTERNATE);
			if (event.commandKey) executingModifierList.push(Keyboard.COMMAND);
			if (event.shiftKey) executingModifierList.push(Keyboard.SHIFT);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function addHotkey(hotkey:Hotkey):Hotkey
		{
			if (hotkeyList.indexOf(hotkey) == -1)
			{
				hotkeyList[hotkeyList.length] = hotkey;
			}
			
			return hotkey;
		}
		
		public function removeHotkey(hotkey:Hotkey):Hotkey
		{
			var index:int = hotkeyList.indexOf(hotkey);
			
			if (index == -1)
			{
				hotkeyList.splice(index, 1);
			}
			
			return hotkey;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Handlers
		//
		//--------------------------------------------------------------------------
		
		protected function keyUpHandler(event:KeyboardEvent):void
		{
			populateExecutingModifierList(event);
			
			var executingKey:String = String.fromCharCode(event.charCode);
			var executingHotkeyString:String = 
				(executingModifierList.length > 0) ? executingModifierList.join('+') + executingKey : executingKey;

			for each (var hotkey:Hotkey in hotkeyList)
			{
				if (executingHotkeyString == String(hotkey) && 
					(hotkey.osList && hotkey.osList.indexOf(_os) != -1 || !hotkey.osList) && 
					hotkey.enabled)
				{
					hotkey.execute();

					break;
				}
			}
		}
	}
}