package com.destroytoday.hotkey
{
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;
	import mockolate.verify;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.osflash.signals.Signal;

	public class HotkeyManagerTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var manager:HotkeyManager;
		
		protected var stage:Stage;
		
		protected var hotkey:IHotkey;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before(async, timeout=5000)]
		public function setUp():void
		{
			manager = new HotkeyManager();
			stage = new NativeWindow(new NativeWindowInitOptions()).stage;
			
			Async.proceedOnEvent(this, prepare(Signal), Event.COMPLETE);
		}
		
		[After]
		public function tearDown():void
		{
			manager = null;
			stage = null;
			hotkey = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Helpers
		//
		//--------------------------------------------------------------------------
		
		protected function dispatchKeyDownEvent(stage:Stage, charCode:uint = 0, keyCode:uint = 0, commandKey:Boolean = false, controlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false):void
		{
			stage.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, charCode, keyCode, 0, false, altKey, shiftKey, controlKey, commandKey));
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function manager_returns_false_if_stage_does_not_exist():void
		{
			assertThat(manager.hasStage(stage), not(true));
		}
		
		[Test]
		public function manager_can_add_stage():void
		{
			manager.addStage(stage);
			
			assertThat(manager.hasStage(stage));
		}
		
		[Test]
		public function adding_stage_to_manager_returns_stage():void
		{
			assertThat(manager.addStage(stage) === stage);
		}
		
		[Test(expects="ArgumentError")]
		public function manager_throws_error_when_stage_exists():void
		{
			manager.addStage(stage);
			manager.addStage(stage);
		}
		
		[Test]
		public function manager_can_remove_stage():void
		{
			manager.addStage(stage);
			manager.removeStage(stage);
			
			assertThat(manager.hasStage(stage), not(true));
		}
		
		[Test]
		public function removing_stage_from_manager_returns_stage():void
		{
			manager.addStage(stage);
			
			assertThat(manager.removeStage(stage) === stage);
		}
		
		[Test(expects="ArgumentError")]
		public function manager_throws_error_when_removing_stage_that_does_not_exist():void
		{
			manager.removeStage(stage);
		}
		
		[Test]
		public function manager_listens_for_key_down_when_adding_stage():void
		{
			manager.addStage(stage);
			
			assertThat(stage.hasEventListener(KeyboardEvent.KEY_DOWN));
		}
		
		[Test]
		public function manager_stops_listening_to_key_down_when_removing_stage():void
		{
			manager.addStage(stage);
			manager.removeStage(stage);
			
			assertThat(stage.hasEventListener(KeyboardEvent.KEY_DOWN), not(true));
		}
		
		[Test]
		public function manager_returns_false_if_hotkey_does_not_exist():void
		{
			assertThat(manager.hasHotkey(new Hotkey("command+s")), not(true));
		}
		
		[Test]
		public function manager_can_add_hotkey():void
		{
			manager.addStage(stage);
			hotkey = new Hotkey("command+s");
			
			manager.addHotkey(hotkey);
			
			assertThat(manager.hasHotkey(hotkey));
		}
		
		[Test]
		public function adding_hotkey_to_manager_returns_hotkey():void
		{
			manager.addStage(stage);
			hotkey = new Hotkey("command+s");
			
			assertThat(manager.addHotkey(hotkey), equalTo(hotkey));
		}
		
		[Test(expects="ArgumentError")]
		public function adding_hotkey_to_manager_when_combination_exists_throws_error():void
		{
			manager.addStage(stage);
			manager.addHotkey(new Hotkey("command+s"));
			manager.addHotkey(new Hotkey("command+s"));
		}
		
		[Test]
		public function manager_can_remove_hotkey():void
		{
			manager.addStage(stage);
			hotkey = new Hotkey("command+s");
			
			manager.addHotkey(hotkey);
			manager.removeHotkey(hotkey);
			
			assertThat(manager.hasHotkey(hotkey), not(true));
		}
		
		[Test(expects="ArgumentError")]
		public function removing_hotkey_from_manager_when_combination_does_not_exist_throws_error():void
		{
			manager.addStage(stage);
			manager.removeHotkey(new Hotkey("command+s"));
		}
		
		[Test]
		public function removing_hotkey_from_manager_returns_hotkey():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("command+s"));
			
			assertThat(manager.removeHotkey(hotkey), equalTo(hotkey));
		}
		
		[Test]
		public function manager_can_get_hotkey_with_combination():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("command+s"));
			
			assertThat(manager.getHotkey("command+s") === hotkey);
		}
		
		[Test(expects="ArgumentError")]
		public function manager_throws_error_when_getting_hotkey_that_does_not_exist():void
		{
			manager.addStage(stage);
			manager.getHotkey("command+s");
		}
		
		[Test]
		public function manager_returns_false_if_hotkey_combination_does_not_exist():void
		{
			assertThat(manager.hasHotkeyCombo("command+s"), not(true));
		}
		
		[Test]
		public function manager_can_add_hotkey_combination():void
		{
			manager.addStage(stage);
			manager.addHotkeyCombo("command+s");
			
			assertThat(manager.hasHotkeyCombo("command+s"));
		}
		
		[Test(expects="ArgumentError")]
		public function manager_throws_error_when_adding_hotkey_combo_that_exists():void
		{
			manager.addStage(stage);
			manager.addHotkeyCombo("command+s");
			manager.addHotkeyCombo("command+s");
		}
		
		[Test]
		public function adding_hotkey_combination_to_manager_returns_hotkey():void
		{
			manager.addStage(stage);
			
			assertThat(manager.addHotkeyCombo("command+s") is IHotkey);
		}
		
		[Test]
		public function manager_can_remove_hotkey_combination():void
		{
			manager.addStage(stage);
			manager.addHotkeyCombo("command+s");
			manager.removeHotkeyCombo("command+s");
			
			assertThat(manager.hasHotkeyCombo("command+s"), not(true));
		}
		
		[Test(expects="ArgumentError")]
		public function manager_throws_error_when_removing_hotkey_combo_that_does_not_exist():void
		{
			manager.addStage(stage);
			manager.removeHotkeyCombo("command+s");
		}
		
		[Test]
		public function removing_hotkey_combination_from_manager_returns_hotkey():void
		{
			manager.addStage(stage);
			manager.addHotkeyCombo("command+s");
			
			assertThat(manager.removeHotkeyCombo("command+s") is IHotkey);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_no_modifiers():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("@"));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 64);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_command_modifier():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("command+@"));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 64, 0, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_control_modifier():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("control+@"));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 64, 0, false, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_alt_modifier():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("alt+" + Keyboard.J));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 0, Keyboard.J, false, false, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_shift_modifier():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("shift+" + Keyboard.J));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 0, Keyboard.J, false, false, false, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_command_control_modifiers():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("command+control+@"));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 64, 0, true, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_command_alt_modifiers():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("command+alt+" + Keyboard.J));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 0, Keyboard.J, true, false, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_command_shift_modifiers():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("command+shift+" + Keyboard.J));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 0, Keyboard.J, true, false, false, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_command_alt_shift_modifiers():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("command+alt+shift+" + Keyboard.J));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 0, Keyboard.J, true, false, true, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_control_alt_modifiers():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("control+alt+" + Keyboard.J));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 0, Keyboard.J, false, true, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_control_shift_modifiers():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("control+shift+" + Keyboard.J));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 0, Keyboard.J, false, true, false, true);
			
			verify(hotkey.executed);
		}

		[Test]
		public function key_down_executes_hotkey_with_control_alt_shift_modifiers():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("control+alt+shift+" + Keyboard.J));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 0, Keyboard.J, false, true, true, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_does_not_execute_disabled_hotkey():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("@"));
			hotkey.executed = strict(Signal);
			hotkey.enabled = false;
			
			mock(hotkey.executed).method('dispatch').never();
			dispatchKeyDownEvent(stage, 64);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function char_hotkeys_ignore_shift_modifier():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("F"));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 70, 0, false, false, false, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function char_hotkeys_ignore_alt_modifier():void
		{
			manager.addStage(stage);
			hotkey = manager.addHotkey(new Hotkey("@"));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 64, 0, false, false, true);
			
			verify(hotkey.executed);
		}
	}
}