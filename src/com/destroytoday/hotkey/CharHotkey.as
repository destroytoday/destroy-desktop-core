package com.destroytoday.hotkey
{
	import com.destroytoday.model.enum.HotkeyModifier;
	import com.destroytoday.model.enum.OSType;
	
	import flash.ui.Keyboard;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class CharHotkey implements IHotkey
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
			if (value == _executed)
				return;

			_executed = value;
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		protected var _char:String;

		protected var _modifierList:Array;

		protected var _osTypeList:Array;

		protected var _enabled:Boolean = true;

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CharHotkey(char:String, modifierList:Array = null, osTypeList:Array = null)
		{
			this.char = char;
			this.modifierList = modifierList;
			this.osTypeList = osTypeList;
		}

		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------

		public function get char():String
		{
			return _char;
		}

		public function set char(value:String):void
		{
			if (value == _char) return;
			
			_char = value;
		}

		public function get modifierList():Array
		{
			return _modifierList;
		}

		public function set modifierList(value:Array):void
		{
			if (value == _modifierList)
				return;

			_modifierList = value;

			if (_modifierList)
			{
				validateModifierList();
				_modifierList.sort();
			}
		}

		public function get osTypeList():Array
		{
			return _osTypeList;
		}

		public function set osTypeList(value:Array):void
		{
			if (value == _osTypeList)
				return;

			_osTypeList = value;

			if (_osTypeList)
				validateOSList();
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
		//  Protected Methods
		//
		//--------------------------------------------------------------------------

		protected function validateModifierList():void
		{
			const m:int = modifierList.length;

			for (var i:int = 0; i < m; i++)
			{
				var modifier:HotkeyModifier = modifierList[i];
				
				if (modifier == HotkeyModifier.SHIFT || modifier == HotkeyModifier.ALTERNATE)
					throw new TypeError("HotkeyModifier <" + modifier + "> is not supported by char-based hotkeys");

				for (var j:int = 0; j < m; j++)
				{
					if (j != i && modifier == modifierList[j])
						throw new ArgumentError("Duplicate hotkey modifiers found in modifierList");
				}
			}
		}

		protected function validateOSList():void
		{
			const m:int = osTypeList.length;

			for (var i:int = 0; i < m; i++)
			{
				if (!(osTypeList[i] is OSType))
					throw new TypeError("Supplied OS type is not of type OSType");

				for (var j:int = 0; j < m; j++)
				{
					if (j != i && osTypeList[i] == osTypeList[j])
						throw new ArgumentError("Duplicate OS types found in osList");
				}
			}
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
			return (modifierList) ? modifierList.join('+') + '+' + char : char;
		}
	}
}