package com.destroytoday.view.menubar
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;

	public class DefaultMenubarTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var menubar:DefaultMenubar;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
			menubar = new DefaultMenubar();
		}
		
		[After]
		public function tearDown():void
		{
			menubar = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function menubar_is_native_menu():void
		{
			assertThat(menubar is NativeMenu);
		}
		
		[Test]
		public function menubar_creates_app_item():void
		{
			assertThat(menubar.appItem, not(nullValue()));
		}
		
		[Test]
		public function app_item_label_is_app_name():void
		{
			assertThat(menubar.appItem.label, equalTo("FlexUnitApplication"));
		}
		
		[Test]
		public function menubar_adds_app_item_at_first_position():void
		{
			assertThat(menubar.getItemAt(0), menubar.appItem);
		}
		
		[Test]
		public function menubar_adds_default_app_menu_to_app_item():void
		{
			assertThat(menubar.appItem.submenu is DefaultAppMenu);
		}
		
		[Test]
		public function menubar_swaps_app_item_if_exists_when_set():void
		{
			var item:NativeMenuItem = new NativeMenuItem("Application");
			
			menubar.appItem = item;
			
			assertThat(menubar.getItemAt(0), equalTo(item));
		}
		
		[Test]
		public function menubar_creates_file_item():void
		{
			assertThat(menubar.fileItem, not(nullValue()));
		}
		
		[Test]
		public function file_item_label_is_file():void
		{
			assertThat(menubar.fileItem.label, equalTo("File"));
		}
		
		[Test]
		public function menubar_adds_file_item_at_second_position():void
		{
			assertThat(menubar.getItemAt(1), menubar.fileItem);
		}
		
		[Test]
		public function menubar_adds_default_file_menu_to_file_item():void
		{
			assertThat(menubar.fileItem.submenu is DefaultFileMenu);
		}
		
		[Test]
		public function menubar_swaps_file_item_if_exists_when_set():void
		{
			var item:NativeMenuItem = new NativeMenuItem("File");
			
			menubar.fileItem = item;
			
			assertThat(menubar.getItemAt(1), equalTo(item));
		}
		
		[Test]
		public function menubar_creates_edit_item():void
		{
			assertThat(menubar.editItem, not(nullValue()));
		}
		
		[Test]
		public function edit_item_label_is_edit():void
		{
			assertThat(menubar.editItem.label, equalTo("Edit"));
		}
		
		[Test]
		public function menubar_adds_edit_item_at_third_position():void
		{
			assertThat(menubar.getItemAt(2), menubar.editItem);
		}
		
		[Test]
		public function menubar_adds_default_edit_menu_to_edit_item():void
		{
			assertThat(menubar.editItem.submenu is DefaultEditMenu);
		}
		
		[Test]
		public function menubar_swaps_edit_item_if_exists_when_set():void
		{
			var item:NativeMenuItem = new NativeMenuItem("Edit");
			
			menubar.editItem = item;
			
			assertThat(menubar.getItemAt(2), equalTo(item));
		}
		
		[Test]
		public function menubar_creates_window_item():void
		{
			assertThat(menubar.windowItem, not(nullValue()));
		}
		
		[Test]
		public function window_item_label_is_window():void
		{
			assertThat(menubar.windowItem.label, equalTo("Window"));
		}
		
		[Test]
		public function menubar_adds_window_item_at_fourth_position():void
		{
			assertThat(menubar.getItemAt(3), menubar.windowItem);
		}
		
		[Test]
		public function menubar_adds_default_window_menu_to_windnow_item():void
		{
			assertThat(menubar.windowItem.submenu is DefaultWindowMenu);
		}
		
		[Test]
		public function menubar_swaps_window_item_if_exists_when_set():void
		{
			var item:NativeMenuItem = new NativeMenuItem("Window");
			
			menubar.windowItem = item;
			
			assertThat(menubar.getItemAt(3), equalTo(item));
		}
	}
}