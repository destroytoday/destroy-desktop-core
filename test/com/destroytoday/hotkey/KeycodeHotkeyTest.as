package com.destroytoday.hotkey
{
	import com.destroytoday.model.enum.HotkeyModifier;
	import com.destroytoday.model.enum.OSType;
	
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;
	import mockolate.verify;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;
	import org.hamcrest.object.strictlyEqualTo;
	import org.osflash.signals.Signal;

	public class KeycodeHotkeyTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var hotkey:KeycodeHotkey;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before(async, timeout=5000)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(Signal), Event.COMPLETE, 5000);
		}
		
		[After]
		public function tearDown():void
		{
			hotkey = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function keycode_returns_keycode_property_name():void
		{
			assertThat(KeycodeHotkey.getStringFromKeyCode(Keyboard.EQUAL), equalTo('EQUAL'));
		}
		
		[Test(expects="TypeError")]
		public function hotkey_throws_error_when_supplied_modifier_is_not_valid():void
		{
			hotkey = new KeycodeHotkey(Keyboard.A, [new Object()]);
		}
		
		[Test(expects="ArgumentError")]
		public function hotkey_throws_error_when_supplied_modifier_is_duplicate():void
		{
			hotkey = new KeycodeHotkey(Keyboard.A, [HotkeyModifier.COMMAND, HotkeyModifier.COMMAND]);
		}
		
		[Test(expects="TypeError")]
		public function hotkey_throws_error_when_supplied_os_type_is_not_valid():void
		{
			hotkey = new KeycodeHotkey(Keyboard.A, null, [new Object()]);
		}
		
		[Test(expects="ArgumentError")]
		public function hotkey_throws_error_when_supplied_os_type_is_duplicate():void
		{
			hotkey = new KeycodeHotkey(Keyboard.A, null, [OSType.MAC, OSType.MAC]);
		}
		
		[Test]
		public function execute_dispatches_executed_signal():void
		{
			hotkey = new KeycodeHotkey(Keyboard.A);
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			hotkey.execute();
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function hotkey_to_string_returns_keyCode_property():void
		{
			hotkey = new KeycodeHotkey(Keyboard.A, null, [OSType.MAC]);
			
			assertThat(hotkey.toString(), equalTo("{Keyboard.A}"));
		}
		
		[Test]
		public function hotkey_with_modifier_to_string_returns_modifier_plus_keyCode_property():void
		{
			hotkey = new KeycodeHotkey(Keyboard.A, [HotkeyModifier.COMMAND], [OSType.MAC]);
			
			assertThat(hotkey.toString(), equalTo("command+{Keyboard.A}"));
		}
		
		[Test]
		public function hotkey_with_multiple_modifiers_to_string_returns_modifiers_plus_keyCode_property():void
		{
			hotkey = new KeycodeHotkey(Keyboard.A, [HotkeyModifier.COMMAND, HotkeyModifier.SHIFT], [OSType.MAC]);
			
			assertThat(hotkey.toString(), equalTo("command+shift+{Keyboard.A}"));
		}
		
		[Test]
		public function hotkey_with_unsorted_modifiers_to_string_returns_sorted_modifiers_plus_keyCode_property():void
		{
			hotkey = new KeycodeHotkey(Keyboard.A, [HotkeyModifier.SHIFT, HotkeyModifier.COMMAND], [OSType.MAC]);
			
			assertThat(hotkey.toString(), equalTo("command+shift+{Keyboard.A}"));
		}
	}
}