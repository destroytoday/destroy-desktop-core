package com.destroytoday.view.menubar
{
	import com.destroytoday.support.ActiveNativeWindow;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowDisplayState;
	import flash.display.NativeWindowInitOptions;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NativeWindowDisplayStateEvent;
	import flash.ui.Keyboard;
	
	import mockolate.ingredients.MockingCouverture;
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.received;
	import mockolate.strict;
	import mockolate.stub;
	import mockolate.verify;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.arrayWithSize;
	import org.hamcrest.collection.everyItem;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.hasPropertyWithValue;
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
		
		[Before(async, timeout=5000)]
		public function setUp():void
		{
			testRunnerWindow = NativeApplication.nativeApplication.openedWindows[0];
			menu = new DefaultWindowMenu();
			
			Async.proceedOnEvent(this,
		        prepare(NativeWindow, ActiveNativeWindow),
		        Event.COMPLETE);
		}
		
		[After]
		public function tearDown():void
		{
			for each (var window:NativeWindow in NativeApplication.nativeApplication.openedWindows)
			{
				if (window != testRunnerWindow)
					window.close();
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
		public function selecting_minimize_item_minimizes_active_window():void
		{
			var window:ActiveNativeWindow = nice(ActiveNativeWindow);
			
			mock(window).method('close').callsSuper();
			menu.minimizeItem.dispatchEvent(new Event(Event.SELECT));
			
			assertThat(window, received().method('minimize').once());
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
		public function selecting_maximize_item_maximizes_normal_active_window():void
		{
			var window:ActiveNativeWindow = nice(ActiveNativeWindow);
			
			mock(window).method('close').callsSuper();
			stub(window).getter('displayState').returns(NativeWindowDisplayState.NORMAL);
			menu.maximizeItem.dispatchEvent(new Event(Event.SELECT));
			
			assertThat(window, received().method('maximize').once());
		}
		
		[Test]
		public function selecting_maximize_item_restores_maximized_active_window():void
		{
			var window:ActiveNativeWindow = nice(ActiveNativeWindow);

			mock(window).method('close').callsSuper();
			stub(window).getter('displayState').returns(NativeWindowDisplayState.MAXIMIZED);
			menu.maximizeItem.dispatchEvent(new Event(Event.SELECT));
			
			assertThat(window, received().method('restore').once());
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
		
		[Test]
		public function selecting_bring_all_to_front_item_makes_windows_visible():void
		{
			var window:NativeWindow = nice(NativeWindow, null, [new NativeWindowInitOptions()]);
			
			mock(window).method('close').callsSuper();
			menu.bringAllToFrontItem.dispatchEvent(new Event(Event.SELECT));
			
			assertThat(window, received().setter('visible').once().arg(true));
		}
		
		[Test]
		public function selecting_bring_all_to_front_item_brings_windows_to_front():void
		{
			var window:NativeWindow = nice(NativeWindow, null, [new NativeWindowInitOptions()]);
			
			mock(window).method('close').callsSuper();
			menu.bringAllToFrontItem.dispatchEvent(new Event(Event.SELECT));
			
			assertThat(window, received().method('orderToFront').once());
		}
	}
}