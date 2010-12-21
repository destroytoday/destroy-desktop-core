package com.destroytoday.view.menubar
{
	import flash.display.NativeMenu;
	import flash.ui.Keyboard;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.everyItem;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;

	public class DefaultAppMenuTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var menu:DefaultAppMenu;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
			menu = new DefaultAppMenu();
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
		public function menu_creates_about_item():void
		{
			assertThat(menu.aboutItem, not(nullValue()));
		}
		
		[Test]
		public function about_item_label_is_about_app_name():void
		{
			assertThat(menu.aboutItem.label, equalTo("About FlexUnitApplication"));
		}

		[Test]
		public function menu_adds_about_item_at_first_position():void
		{
			assertThat(menu.getItemAt(0), equalTo(menu.aboutItem));
		}
		
		[Test]
		public function menu_adds_separator_after_about_item():void
		{
			assertThat(menu.getItemAt(1).isSeparator);
		}
		
		[Test]
		public function menu_creates_preferences_item():void
		{
			assertThat(menu.preferencesItem, not(nullValue()));
		}
		
		[Test]
		public function preferences_item_label_is_preferences_dot_dot_dot():void
		{
			assertThat(menu.preferencesItem.label, equalTo("Preferences..."));
		}
		
		[Test]
		public function preferences_item_has_command_comma_hotkey():void
		{
			assertThat(menu.preferencesItem.keyEquivalentModifiers, everyItem(equalTo(Keyboard.COMMAND)));
			assertThat(menu.preferencesItem.keyEquivalent, equalTo(","));
		}

		[Test]
		public function menu_adds_preferences_item_at_third_position():void
		{
			assertThat(menu.getItemAt(2), equalTo(menu.preferencesItem));
		}
		
		[Test]
		public function menu_adds_separator_after_preferences_item():void
		{
			assertThat(menu.getItemAt(3).isSeparator);
		}
		
		[Test]
		public function menu_creates_quit_item():void
		{
			assertThat(menu.quitItem, not(nullValue()));
		}
		
		[Test]
		public function quit_item_label_is_quit():void
		{
			assertThat(menu.quitItem.label, equalTo("Quit"));
		}
		
		[Test]
		public function quit_item_has_command_q_hotkey():void
		{
			assertThat(menu.quitItem.keyEquivalentModifiers, everyItem(equalTo(Keyboard.COMMAND)));
			assertThat(menu.quitItem.keyEquivalent, equalTo("q"));
		}

		[Test]
		public function menu_adds_quitItem_item_at_fifth_position():void
		{
			assertThat(menu.getItemAt(4), equalTo(menu.quitItem));
		}
	}
}