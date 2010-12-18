package com.destroytoday.hotkey
{
	import org.osflash.signals.Signal;
	
	public class Hotkey implements IHotkey
	{
		//--------------------------------------------------------------------------
		//
		//  Static Constants
		//
		//--------------------------------------------------------------------------
		
		protected static const combinationValidationRegex:RegExp = /^(?:(?:(?:(?:command|control)\+){0,2}\S)|(?:(?:(?:command|control|alt|shift)\+){0,4}[0-9]+))$/;
		
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
		
		protected var _combination:String;
		
		protected var _enabled:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function Hotkey(combination:*)
		{
			this.combination = String(combination);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
		}
		
		public function get combination():String
		{
			return _combination;
		}
		
		public function set combination(value:String):void
		{
			if (value == _combination) return;
			
			_combination = value;
			
			validateCombination();
			sortModifiers();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function sortModifiers():void
		{
			var modifierStr:String = '';
			
			if (_combination.indexOf("command") != -1)
				modifierStr += "command+";
			
			if (_combination.indexOf("control") != -1)
				modifierStr += "control+";
			
			if (_combination.indexOf("alt") != -1)
				modifierStr += "alt+";
			
			if (_combination.indexOf("shift") != -1)
				modifierStr += "shift+";
			
			var combinationPartList:Array = _combination.split('+');
			
			_combination = modifierStr + combinationPartList[combinationPartList.length - 1];
		}
		
		protected function validateCombination():void
		{
			if (!combinationValidationRegex.test(_combination))
				throw new ArgumentError("Invalid hotkey combination");
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
			return _combination;
		}
	}
}