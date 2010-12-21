package com.destroytoday.view.menubar
{
	import com.destroytoday.view.component.menu.Menu;
	import com.destroytoday.view.component.menu.MenuItem;
	
	import flash.display.NativeMenuItem;
	import flash.ui.Keyboard;

	public class DefaultEditMenu extends Menu
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _cutItem:NativeMenuItem;
		
		protected var _copyItem:NativeMenuItem;
		
		protected var _pasteItem:NativeMenuItem;
		
		protected var _selectAllItem:NativeMenuItem;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function DefaultEditMenu()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get cutItem():NativeMenuItem
		{
			return _cutItem ||= new MenuItem("Cut", [Keyboard.COMMAND], "x");
		}

		public function set cutItem(value:NativeMenuItem):void
		{
			if (value == _cutItem) return;
			
			_cutItem = (_cutItem) ? swapItems(_cutItem, value) : value;
		}
		
		public function get copyItem():NativeMenuItem
		{
			return _copyItem ||= new MenuItem("Copy", [Keyboard.COMMAND], "c");
		}
		
		public function set copyItem(value:NativeMenuItem):void
		{
			if (value == _copyItem) return;
			
			_copyItem = (_copyItem) ? swapItems(_copyItem, value) : value;
		}
		
		public function get pasteItem():NativeMenuItem
		{
			return _pasteItem ||= new MenuItem("Paste", [Keyboard.COMMAND], "v");
		}
		
		public function set pasteItem(value:NativeMenuItem):void
		{
			if (value == _pasteItem) return;
			
			_pasteItem = (_pasteItem) ? swapItems(_pasteItem, value) : value;
		}
		
		public function get selectAllItem():NativeMenuItem
		{
			return _selectAllItem ||= new MenuItem("Select All", [Keyboard.COMMAND], "a");
		}
		
		public function set selectAllItem(value:NativeMenuItem):void
		{
			if (value == _selectAllItem) return;
			
			_selectAllItem = (_selectAllItem) ? swapItems(_selectAllItem, value) : value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		override protected function addInitialItems():void
		{
			addItem(cutItem);
			addItem(copyItem);
			addItem(pasteItem);
			addItem(selectAllItem);
		}
	}
}