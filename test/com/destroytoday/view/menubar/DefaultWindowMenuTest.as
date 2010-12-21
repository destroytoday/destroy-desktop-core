package com.destroytoday.view.menubar
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.Sprite;
	import flash.ui.Keyboard;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.arrayWithSize;
	import org.hamcrest.collection.everyItem;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;

	public class DefaultWindowMenuTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var testRunnerWindow:NativeWindow;
		
		protected var menu:DefaultWindowMenu;

		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
			testRunnerWindow = NativeApplication.nativeApplication.openedWindows[0];
			menu = new DefaultWindowMenu();
		}
		
		[After]
		public function tearDown():void
		{
			var m:int = NativeApplication.nativeApplication.openedWindows.length;
			
			for (var i:int = 1; i < m; i++)
			{
				(NativeApplication.nativeApplication.openedWindows[i] as NativeWindow).close();
			}
			
			testRunnerWindow = null;
			
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
		public function menu_creates_minimize_item():void
		{
			assertThat(menu.minimizeItem, not(nullValue()));
		}
		
		[Test]
		public function minimize_item_label_is_minimize():void
		{
			assertThat(menu.minimizeItem.label, equalTo("Minimize"));
		}
		
		[Test]
		public function minimize_item_hotkey_is_command_m():void
		{
			assertThat(menu.minimizeItem.keyEquivalentModifiers, everyItem(equalTo(Keyboard.COMMAND)));
			assertThat(menu.minimizeItem.keyEquivalent, equalTo("m"));
		}

		[Test]
		public function menu_adds_minimize_item_at_first_position():void
		{
			assertThat(menu.getItemAt(0), equalTo(menu.minimizeItem));
		}
		
		[Test]
		public function minimize_item_is_enabled_when_a_minimizable_window_is_focused():void
		{
			testRunnerWindow.activate();
			menu.updateItems();
			
			assertThat(menu.minimizeItem.enabled);
		}
		
		[Test]
		public function minimize_item_is_disabled_when_a_minimize_disabled_window_is_focused():void
		{
			var options:NativeWindowInitOptions = new NativeWindowInitOptions();
			options.minimizable = false;
			
			var window:NativeWindow = new NativeWindow(options);
			
			window.activate();
			menu.updateItems();

			assertThat(menu.minimizeItem.enabled, not(true));
		}
		
		[Test]
		public function minimize_item_is_disabled_when_no_windows_are_focused():void
		{
			testRunnerWindow.visible = false;
			testRunnerWindow.visible = true;
			menu.updateItems();

			assertThat(menu.minimizeItem.enabled, not(true));
		}
		
		[Test]
		public function menu_creates_maximize_item():void
		{
			assertThat(menu.maximizeItem, not(nullValue()));
		}
		
		[Test]
		public function maximize_item_label_is_minimize():void
		{
			assertThat(menu.maximizeItem.label, equalTo("Maximize"));
		}
		
		[Test]
		public function maximize_item_hotkey_is_command_shift_m():void
		{
			assertThat(menu.maximizeItem.keyEquivalentModifiers[0], everyItem(equalTo(Keyboard.COMMAND)));
			assertThat(menu.maximizeItem.keyEquivalent, equalTo("M"));
		}

		[Test]
		public function menu_adds_maximize_item_at_second_position():void
		{
			assertThat(menu.getItemAt(1), equalTo(menu.maximizeItem));
		}
		
		[Test]
		public function maximize_item_is_enabled_when_a_maximizable_window_is_focused():void
		{
			testRunnerWindow.activate();
			menu.updateItems();
			
			assertThat(menu.minimizeItem.enabled);
		}

		[Test]
		public function maximize_item_is_disabled_when_a_maximize_disabled_window_is_focused():void
		{
			var options:NativeWindowInitOptions = new NativeWindowInitOptions();
			options.maximizable = false;
			
			var window:NativeWindow = new NativeWindow(options);
			
			window.activate();
			menu.updateItems();

			assertThat(menu.maximizeItem.enabled, not(true));
		}

		[Test]
		public function maximize_item_is_disabled_when_no_windows_are_focused():void
		{
			testRunnerWindow.visible = false;
			testRunnerWindow.visible = true;
			menu.updateItems();

			assertThat(menu.maximizeItem.enabled, not(true));
		}
		
		[Test]
		public function menu_adds_separator_after_maximize_item():void
		{
			assertThat(menu.getItemAt(2).isSeparator);
		}
		
		[Test]
		public function menu_creates_bring_all_to_front_item():void
		{
			assertThat(menu.bringAllToFrontItem, not(nullValue()));
		}
		
		[Test]
		public function bring_all_to_front_item_label_is_bring_all_to_front():void
		{
			assertThat(menu.bringAllToFrontItem.label, equalTo("Bring All to Front"));
		}

		[Test]
		public function menu_adds_bring_all_to_front_item_at_forth_position():void
		{
			assertThat(menu.getItemAt(3), equalTo(menu.bringAllToFrontItem));
		}
	}
}