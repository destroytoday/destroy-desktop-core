package com.destroytoday.view.menubar
{
	import com.destroytoday.view.component.menu.Menu;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	
	public class DefaultMenubar extends Menu
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		protected var _appItem:NativeMenuItem;
		
		protected var _fileItem:NativeMenuItem;

		protected var _editItem:NativeMenuItem;
		
		protected var _windowItem:NativeMenuItem;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function DefaultMenubar()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get appItem():NativeMenuItem
		{
			if (!_appItem)
			{
				var descriptor:XML = NativeApplication.nativeApplication.applicationDescriptor;
				var ns:Namespace = descriptor.namespace();
				var appName:String = descriptor.ns::name;

				_appItem = new NativeMenuItem(appName);
				_appItem.submenu = new DefaultAppMenu();
			}
			
			return _appItem;
		}
		
		public function set appItem(value:NativeMenuItem):void
		{
			if (value == _appItem) return;
			
			_appItem = (_appItem) ? swapItems(_appItem, value) : value;
		}
		
		public function get fileItem():NativeMenuItem
		{
			if (!_fileItem)
			{
				_fileItem = new NativeMenuItem("File");
				_fileItem.submenu = new DefaultFileMenu();
			}
			
			return _fileItem;
		}
		
		public function set fileItem(value:NativeMenuItem):void
		{
			if (value == _fileItem) return;
			
			_fileItem = (_fileItem) ? swapItems(_fileItem, value) : value;
		}
		
		public function get editItem():NativeMenuItem
		{
			if (!_editItem)
			{
				_editItem = new NativeMenuItem("Edit");
				_editItem.submenu = new DefaultEditMenu();
			}
			
			return _editItem;
		}
		
		public function set editItem(value:NativeMenuItem):void
		{
			if (value == _editItem) return;
			
			_editItem = (_editItem) ? swapItems(_editItem, value) : value;
		}
		
		public function get windowItem():NativeMenuItem
		{
			if (!_windowItem)
			{
				_windowItem = new NativeMenuItem("Window");
				_windowItem.submenu = new DefaultWindowMenu();
			}
			
			return _windowItem;
		}
		
		public function set windowItem(value:NativeMenuItem):void
		{
			if (value == _windowItem) return;
			
			_windowItem = (_windowItem) ? swapItems(_windowItem, value) : value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		override protected function addInitialItems():void
		{
			addItem(appItem);
			addItem(fileItem);
			addItem(editItem);
			addItem(windowItem);
		}
	}
}