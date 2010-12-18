package com.destroytoday.hotkey
{
	import com.destroytoday.environment.OS;
	import com.destroytoday.model.enum.HotkeyModifier;
	import com.destroytoday.model.enum.OSType;
	
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.strict;
	import mockolate.stub;
	import mockolate.verify;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.not;
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
			stage = new NativeWindow(new NativeWindowInitOptions()).stage;
			
			Async.proceedOnEvent(this, prepare(OS, Signal), Event.COMPLETE);
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
		public function manager_listens_for_key_down_when_stage_is_set():void
		{
			manager = new HotkeyManager(stage);
			
			assertThat(stage.hasEventListener(KeyboardEvent.KEY_DOWN));
		}
		
		[Test]
		public function manager_stops_listening_to_key_down_on_old_stage_when_new_stage_is_set():void
		{
			manager = new HotkeyManager(stage);
			var oldStage:Stage = stage;
			
			manager.stage = new NativeWindow(new NativeWindowInitOptions()).stage;
			
			assertThat(not(oldStage.hasEventListener(KeyboardEvent.KEY_DOWN)));
		}
		
		[Test]
		public function can_add_hotkey_to_list():void
		{
			manager = new HotkeyManager(stage);
			hotkey = new Hotkey("@");
			
			manager.addHotkey(hotkey);
			
			assertThat(manager.hasHotkey(hotkey));
		}
		
		[Test]
		public function can_remove_hotkey_from_list():void
		{
			manager = new HotkeyManager(stage);
			hotkey = new Hotkey("@");
			
			manager.addHotkey(hotkey);
			manager.removeHotkey(hotkey);
			
			assertThat(not(manager.hasHotkey(hotkey)));
		}
		
		[Test]
		public function key_down_executes_hotkey_with_no_modifiers():void
		{
			manager = new HotkeyManager(stage);
			hotkey = manager.addHotkey(new Hotkey("@"));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 64);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_command_modifier():void
		{
			manager = new HotkeyManager(stage);
			hotkey = manager.addHotkey(new Hotkey("command+@"));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 64, 0, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_control_modifier():void
		{
			manager = new HotkeyManager(stage);
			hotkey = manager.addHotkey(new Hotkey("control+@"));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 64, 0, false, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_alt_modifier():void
		{
			manager = new HotkeyManager(stage);
			hotkey = manager.addHotkey(new Hotkey("alt+" + Keyboard.J));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 0, Keyboard.J, false, false, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_shift_modifier():void
		{
			manager = new HotkeyManager(stage);
			hotkey = manager.addHotkey(new Hotkey("shift+" + Keyboard.J));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 0, Keyboard.J, false, false, false, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_command_control_modifiers():void
		{
			manager = new HotkeyManager(stage);
			hotkey = manager.addHotkey(new Hotkey("command+control+@"));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 64, 0, true, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_command_alt_modifiers():void
		{
			manager = new HotkeyManager(stage);
			hotkey = manager.addHotkey(new Hotkey("command+alt+" + Keyboard.J));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 0, Keyboard.J, true, false, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_command_shift_modifiers():void
		{
			manager = new HotkeyManager(stage);
			hotkey = manager.addHotkey(new Hotkey("command+shift+" + Keyboard.J));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 0, Keyboard.J, true, false, false, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_command_alt_shift_modifiers():void
		{
			manager = new HotkeyManager(stage);
			hotkey = manager.addHotkey(new Hotkey("command+alt+shift+" + Keyboard.J));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 0, Keyboard.J, true, false, true, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_control_alt_modifiers():void
		{
			manager = new HotkeyManager(stage);
			hotkey = manager.addHotkey(new Hotkey("control+alt+" + Keyboard.J));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 0, Keyboard.J, false, true, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_control_shift_modifiers():void
		{
			manager = new HotkeyManager(stage);
			hotkey = manager.addHotkey(new Hotkey("control+shift+" + Keyboard.J));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 0, Keyboard.J, false, true, false, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_executes_hotkey_with_control_alt_shift_modifiers():void
		{
			manager = new HotkeyManager(stage);
			hotkey = manager.addHotkey(new Hotkey("control+alt+shift+" + Keyboard.J));
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			dispatchKeyDownEvent(stage, 0, Keyboard.J, false, true, true, true);
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function key_down_does_not_execute_disabled_hotkey():void
		{
			manager = new HotkeyManager(stage);
			hotkey = manager.addHotkey(new Hotkey("@"));
			hotkey.executed = strict(Signal);
			hotkey.enabled = false;
			
			mock(hotkey.executed).method('dispatch').never();
			dispatchKeyDownEvent(stage, 64);
			
			verify(hotkey.executed);
		}
	}
}