package com.destroytoday.view.menubar
{
	import flash.display.NativeMenu;
	import flash.ui.Keyboard;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.everyItem;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;

	public class DefaultEditMenuTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var menu:DefaultEditMenu;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
			menu = new DefaultEditMenu();
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
		public function menu_creates_cut_item():void
		{
			assertThat(menu.cutItem, not(nullValue()));
		}
		
		[Test]
		public function cut_item_label_is_cut():void
		{
			assertThat(menu.cutItem.label, equalTo("Cut"));
		}
		
		[Test]
		public function cut_item_hotkey_is_command_x():void
		{
			assertThat(menu.cutItem.keyEquivalentModifiers, everyItem(equalTo(Keyboard.COMMAND)));
			assertThat(menu.cutItem.keyEquivalent, equalTo("x"));
		}

		[Test]
		public function menu_adds_cut_item_at_first_position():void
		{
			assertThat(menu.getItemAt(0), equalTo(menu.cutItem));
		}
		
		[Test]
		public function menu_creates_copy_item():void
		{
			assertThat(menu.copyItem, not(nullValue()));
		}
		
		[Test]
		public function copy_item_label_is_copy():void
		{
			assertThat(menu.copyItem.label, equalTo("Copy"));
		}
		
		[Test]
		public function copy_item_hotkey_is_command_c():void
		{
			assertThat(menu.copyItem.keyEquivalentModifiers, everyItem(equalTo(Keyboard.COMMAND)));
			assertThat(menu.copyItem.keyEquivalent, equalTo("c"));
		}

		[Test]
		public function menu_adds_copy_item_at_second_position():void
		{
			assertThat(menu.getItemAt(1), equalTo(menu.copyItem));
		}
		
		[Test]
		public function menu_creates_paste_item():void
		{
			assertThat(menu.pasteItem, not(nullValue()));
		}
		
		[Test]
		public function paste_item_label_is_paste():void
		{
			assertThat(menu.pasteItem.label, equalTo("Paste"));
		}
		
		[Test]
		public function paste_item_hotkey_is_command_c():void
		{
			assertThat(menu.pasteItem.keyEquivalentModifiers, everyItem(equalTo(Keyboard.COMMAND)));
			assertThat(menu.pasteItem.keyEquivalent, equalTo("v"));
		}

		[Test]
		public function menu_adds_paste_item_at_third_position():void
		{
			assertThat(menu.getItemAt(2), equalTo(menu.pasteItem));
		}
		
		[Test]
		public function menu_creates_select_all_item():void
		{
			assertThat(menu.selectAllItem, not(nullValue()));
		}
		
		[Test]
		public function select_all_item_label_is_select_all():void
		{
			assertThat(menu.selectAllItem.label, equalTo("Select All"));
		}
		
		[Test]
		public function select_all_item_hotkey_is_command_a():void
		{
			assertThat(menu.selectAllItem.keyEquivalentModifiers, everyItem(equalTo(Keyboard.COMMAND)));
			assertThat(menu.selectAllItem.keyEquivalent, equalTo("a"));
		}

		[Test]
		public function menu_adds_select_all_item_at_forth_position():void
		{
			assertThat(menu.getItemAt(3), equalTo(menu.selectAllItem));
		}
	}
}