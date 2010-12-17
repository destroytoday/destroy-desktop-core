package com.destroytoday.hotkey
{
	import com.destroytoday.environment.OS;
	import com.destroytoday.model.enum.HotkeyModifier;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;

	public class HotkeyManager
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		protected var _os:OS;

		protected var _stage:Stage;

		protected var hotkeyList:Vector.<IHotkey> = new Vector.<IHotkey>();

		protected var executingCharCodeModifierList:Vector.<HotkeyModifier> = new Vector.<HotkeyModifier>();

		protected var executingKeyCodeModifierList:Vector.<HotkeyModifier> = new Vector.<HotkeyModifier>();

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
			if (value == _stage)
				return;

			if (_stage)
			{
				_stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			}

			_stage = value;

			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}

		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------

		protected function populateExecutingModifierLists(event:KeyboardEvent):void
		{
			executingCharCodeModifierList.length = 0;
			executingKeyCodeModifierList.length = 0;

			if (event.altKey)
				executingKeyCodeModifierList.push(HotkeyModifier.ALTERNATE);

			if (event.commandKey)
			{
				executingCharCodeModifierList.push(HotkeyModifier.COMMAND);
				executingKeyCodeModifierList.push(HotkeyModifier.COMMAND);
			}

			if (event.controlKey)
			{
				executingCharCodeModifierList.push(HotkeyModifier.CONTROL);
				executingKeyCodeModifierList.push(HotkeyModifier.CONTROL);
			}

			if (event.shiftKey)
				executingKeyCodeModifierList.push(HotkeyModifier.SHIFT);
		}

		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------

		public function addHotkey(hotkey:IHotkey):IHotkey
		{
			if (hotkeyList.indexOf(hotkey) == -1)
			{
				hotkeyList[hotkeyList.length] = hotkey;
			}

			return hotkey;
		}

		public function removeHotkey(hotkey:IHotkey):IHotkey
		{
			var index:int = hotkeyList.indexOf(hotkey);

			if (index == -1)
			{
				hotkeyList.splice(index, 1);
			}

			return hotkey;
		}

		public function hasHotkey(hotkey:IHotkey):Boolean
		{
			return hotkeyList.indexOf(hotkey) != -1;
		}

		//--------------------------------------------------------------------------
		//
		//  Handlers
		//
		//--------------------------------------------------------------------------

		protected function keyDownHandler(event:KeyboardEvent):void
		{
			populateExecutingModifierLists(event);

			var executingCharCodeString:String = String.fromCharCode(event.charCode);
			var executingKeyCodeString:String = KeycodeHotkey.getStringFromKeyCode(event.keyCode);

			if (executingKeyCodeString)
				executingKeyCodeString = '{Keyboard.' + executingKeyCodeString +'}';

			if (executingCharCodeModifierList.length > 0)
				executingCharCodeString = executingCharCodeModifierList.join('+') + '+' + executingCharCodeString;

			if (executingKeyCodeString && executingKeyCodeModifierList.length > 0)
				executingKeyCodeString = executingKeyCodeModifierList.join('+') + '+' + executingKeyCodeString;

			for each (var hotkey:IHotkey in hotkeyList)
			{
				if ((
						(hotkey is CharHotkey && String(hotkey) == executingCharCodeString) || 
						(hotkey is KeycodeHotkey && String(hotkey) == executingKeyCodeString)
					) && 
					(hotkey.osTypeList && hotkey.osTypeList.indexOf(_os.type) != -1 || !hotkey.osTypeList) && 
					hotkey.enabled)
				{
					hotkey.execute();

					break;
				}
			}
		}
	}
}