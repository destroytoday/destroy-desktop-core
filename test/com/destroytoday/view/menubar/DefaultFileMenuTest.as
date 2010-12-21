package com.destroytoday.view.menubar
{
	import flash.display.NativeMenu;
	import flash.ui.Keyboard;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.everyItem;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;

	public class DefaultFileMenuTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var menu:DefaultFileMenu;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
			menu = new DefaultFileMenu();
		}
		
		[After]
		public function tearDown():void
		{
			menu = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function menu_is_native_menu():void
		{
			assertThat(menu is NativeMenu);
		}
		
		[Test]
		public function menu_creates_close_item():void
		{
			assertThat(menu.closeItem, not(nullValue()));
		}
		
		[Test]
		public function close_item_label_is_close():void
		{
			assertThat(menu.closeItem.label, equalTo("Close"));
		}
		
		[Test]
		public function close_item_hotkey_is_command_w():void
		{
			assertThat(menu.closeItem.keyEquivalentModifiers, everyItem(equalTo(Keyboard.COMMAND)));
			assertThat(menu.closeItem.keyEquivalent, equalTo("w"));
		}

		[Test]
		public function menu_adds_close_item_at_first_position():void
		{
			assertThat(menu.getItemAt(0), equalTo(menu.closeItem));
		}
	}
}