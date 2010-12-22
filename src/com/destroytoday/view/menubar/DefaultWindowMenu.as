package com.destroytoday.view.menubar
{
	import com.destroytoday.view.component.menu.Menu;
	import com.destroytoday.view.component.menu.MenuItem;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowDisplayState;
	import flash.events.Event;
	import flash.ui.Keyboard;

	public class DefaultWindowMenu extends Menu
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _minimizeItem:NativeMenuItem;

		protected var _maximizeItem:NativeMenuItem;

		protected var _bringAllToFrontItem:NativeMenuItem;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function DefaultWindowMenu()
		{
			addEventListener(Event.DISPLAYING, displayingHandler);
			
			minimizeItem.addEventListener(Event.SELECT, minimizeItemSelectHandler);
			maximizeItem.addEventListener(Event.SELECT, maximizeItemSelectHandler);
			bringAllToFrontItem.addEventListener(Event.SELECT, bringAllToFrontItemSelectHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get minimizeItem():NativeMenuItem
		{
			return _minimizeItem ||= new MenuItem("Minimize", [Keyboard.COMMAND], "m");
		}
		
		public function set minimizeItem(value:NativeMenuItem):void
		{
			if (value == _minimizeItem) return;
			
			_minimizeItem = (_minimizeItem) ? swapItems(_minimizeItem, value) : value;
		}

		public function get maximizeItem():NativeMenuItem
		{
			return _maximizeItem ||= new MenuItem("Maximize", [Keyboard.COMMAND, Keyboard.SHIFT], "m");
		}
		
		public function set maximizeItem(value:NativeMenuItem):void
		{
			if (value == _maximizeItem) return;
			
			_maximizeItem = (_maximizeItem) ? swapItems(_maximizeItem, value) : value;
		}
		
		public function get bringAllToFrontItem():NativeMenuItem
		{
			return _bringAllToFrontItem ||= new MenuItem("Bring All to Front");
		}
		
		public function set bringAllToFrontItem(value:NativeMenuItem):void
		{
			if (value == _bringAllToFrontItem) return;
			
			_bringAllToFrontItem = (_bringAllToFrontItem) ? swapItems(_bringAllToFrontItem, value) : value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Properties
		//
		//--------------------------------------------------------------------------
		
		override protected function addInitialItems():void
		{
			addItem(minimizeItem);
			addItem(maximizeItem);
			addSeparator();
			addItem(bringAllToFrontItem);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		override public function updateItems():void
		{
			minimizeItem.enabled = 
				(NativeApplication.nativeApplication.activeWindow &&
				NativeApplication.nativeApplication.activeWindow.minimizable);
			
			maximizeItem.enabled = 
				(NativeApplication.nativeApplication.activeWindow &&
				NativeApplication.nativeApplication.activeWindow.maximizable);
			
			bringAllToFrontItem.enabled = 
				(NativeApplication.nativeApplication.openedWindows &&
				NativeApplication.nativeApplication.openedWindows.length > 0);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Handlers
		//
		//--------------------------------------------------------------------------

		protected function displayingHandler(event:Event):void
		{
			updateItems();
		}
		
		protected function minimizeItemSelectHandler(event:Event):void
		{
			NativeApplication.nativeApplication.activeWindow.minimize();
		}
		
		protected function maximizeItemSelectHandler(event:Event):void
		{
			var activeWindow:NativeWindow = NativeApplication.nativeApplication.activeWindow;
			
			if (activeWindow.displayState == NativeWindowDisplayState.NORMAL)
			{
				activeWindow.maximize();
			}
			else
			{
				activeWindow.restore();
			}
		}
		
		protected function bringAllToFrontItemSelectHandler(event:Event):void
		{
			var openedWindowList:Array = NativeApplication.nativeApplication.openedWindows;
			
			for each (var window:NativeWindow in openedWindowList)
			{
				window.orderToFront();
				window.visible = true;
			}	
		}
	}
}