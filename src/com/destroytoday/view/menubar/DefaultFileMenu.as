package com.destroytoday.view.menubar
{
	import com.destroytoday.view.component.menu.Menu;
	import com.destroytoday.view.component.menu.MenuItem;
	
	import flash.display.NativeMenuItem;
	import flash.ui.Keyboard;

	public class DefaultFileMenu extends Menu
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _closeItem:NativeMenuItem;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function DefaultFileMenu()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get closeItem():NativeMenuItem
		{
			return _closeItem ||= new MenuItem("Close", [Keyboard.COMMAND], "w");
		}
		
		public function set closeItem(value:NativeMenuItem):void
		{
			if (value == _closeItem) return;
			
			_closeItem = (_closeItem) ? swapItems(_closeItem, value) : value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		override protected function addInitialItems():void
		{
			addItem(closeItem);
		}
	}
}