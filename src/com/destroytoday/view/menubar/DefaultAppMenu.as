package com.destroytoday.view.menubar
{
	import com.destroytoday.view.component.menu.Menu;
	import com.destroytoday.view.component.menu.MenuItem;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.ui.Keyboard;
	
	public class DefaultAppMenu extends Menu
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _aboutItem:NativeMenuItem;

		protected var _preferencesItem:NativeMenuItem;
		
		protected var _quitItem:NativeMenuItem;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function DefaultAppMenu()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get aboutItem():NativeMenuItem
		{
			if (!_aboutItem)
			{
				var descriptor:XML = NativeApplication.nativeApplication.applicationDescriptor;
				var ns:Namespace = descriptor.namespace();
				var appName:String = descriptor.ns::name;
				
				_aboutItem = new MenuItem("About " + appName);
			}
			
			return _aboutItem;
		}
		
		public function set aboutItem(value:NativeMenuItem):void
		{
			if (value == _aboutItem) return;
			
			_aboutItem = (_aboutItem) ? swapItems(_aboutItem, value) : value;
		}
		
		public function get preferencesItem():NativeMenuItem
		{
			return _preferencesItem ||= new MenuItem("Preferences...", [Keyboard.COMMAND], ",");
		}
		
		public function set preferencesItem(value:NativeMenuItem):void
		{
			if (value == _preferencesItem) return;
			
			_preferencesItem = (_preferencesItem) ? swapItems(_preferencesItem, value) : value;
		}
		
		public function get quitItem():NativeMenuItem
		{
			return _quitItem ||= new MenuItem("Quit", [Keyboard.COMMAND], "q");
		}
		
		public function set quitItem(value:NativeMenuItem):void
		{
			if (value == _quitItem) return;
			
			_quitItem = (_quitItem) ? swapItems(_quitItem, value) : value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		override protected function addInitialItems():void
		{
			addItem(aboutItem);
			addSeparator();
			addItem(preferencesItem);
			addSeparator();
			addItem(quitItem);
		}
	}
}