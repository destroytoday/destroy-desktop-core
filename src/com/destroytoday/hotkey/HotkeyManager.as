package com.destroytoday.hotkey
{
	import com.destroytoday.environment.OS;
	import com.destroytoday.model.enum.HotkeyModifier;
	import com.destroytoday.object.ObjectMap;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;

	public class HotkeyManager
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		protected var _stage:Stage;

		protected var hotkeyMap:Object = new Object();

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function HotkeyManager(stage:Stage)
		{
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
			if (value == _stage)
				return;

			if (_stage)
				_stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);

			_stage = value;

			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}

		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------

		public function addHotkeyCombo(combination:String):IHotkey
		{
			if (hasHotkeyCombo(combination))
				throw new ArgumentError("A hotkey with combination <" + combination + "> already exists");
			
			return (hotkeyMap[combination] = new Hotkey(combination));
		}
		
		public function removeHotkeyCombo(combination:String):IHotkey
		{
			if (!hasHotkeyCombo(combination))
				throw new ArgumentError("Hotkey with combination <" + combination + "> does not exist");
			
			var hotkey:IHotkey = getHotkey(combination);
			
			delete hotkeyMap[combination];
			
			return hotkey;
		}
		
		public function hasHotkeyCombo(combination:String):Boolean
		{
			return hotkeyMap[combination] != undefined;
		}
		
		public function addHotkey(hotkey:IHotkey):IHotkey
		{
			if (hasHotkey(hotkey))
				throw new ArgumentError("A hotkey with combination <" + hotkey.combination + "> already exists");
			
			return (hotkeyMap[hotkey.combination] = hotkey);
		}

		public function removeHotkey(hotkey:IHotkey):IHotkey
		{
			if (!hasHotkey(hotkey))
				throw new ArgumentError("Hotkey with combination <" + hotkey.combination + "> does not exist");
			
			delete hotkeyMap[hotkey.combination];
			
			return hotkey;
		}
		
		public function getHotkey(combination:String):IHotkey
		{
			if (!hasHotkeyCombo(combination))
				throw new ArgumentError("A hotkey with combination <" + combination + "> does not exist");
			
			return hotkeyMap[combination];
		}

		public function hasHotkey(hotkey:IHotkey):Boolean
		{
			return hotkeyMap[hotkey.combination] != undefined;
		}

		//--------------------------------------------------------------------------
		//
		//  Handlers
		//
		//--------------------------------------------------------------------------

		protected function keyDownHandler(event:KeyboardEvent):void
		{
			var charCodeModifierStr:String = '';
			var keyCodeModifierStr:String = '';
			
			if (event.commandKey)
			{
				charCodeModifierStr += "command+";
				keyCodeModifierStr += "command+";
			}
			
			if (event.controlKey)
			{
				charCodeModifierStr += "control+";
				keyCodeModifierStr += "control+";
			}
			
			if (event.altKey)
				keyCodeModifierStr += "alt+";
			
			if (event.shiftKey)
				keyCodeModifierStr += "shift+";

			var charCodeCombo:String = charCodeModifierStr + String.fromCharCode(event.charCode);
			var keyCodeCombo:String = keyCodeModifierStr + String(event.keyCode);

			var hotkey:IHotkey;

			if (((hotkey = hotkeyMap[charCodeCombo]) || (hotkey = hotkeyMap[keyCodeCombo])) && hotkey.enabled)
				hotkey.execute();
		}
	}
}