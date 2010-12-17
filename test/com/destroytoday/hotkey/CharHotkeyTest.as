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

	public class CharHotkeyTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var hotkey:CharHotkey;
		
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
		
		[Test(expects="TypeError")]
		public function hotkey_throws_error_when_supplied_modifier_is_not_valid():void
		{
			hotkey = new CharHotkey("@", [new Object()]);
		}
		
		[Test(expects="TypeError")]
		public function hotkey_throws_error_when_shift_is_a_modifier():void
		{
			hotkey = new CharHotkey("@", [HotkeyModifier.SHIFT]);
		}
		
		[Test(expects="TypeError")]
		public function hotkey_throws_error_when_alt_is_a_modifier():void
		{
			hotkey = new CharHotkey("@", [HotkeyModifier.ALTERNATE]);
		}
		
		[Test(expects="ArgumentError")]
		public function hotkey_throws_error_when_supplied_modifier_is_duplicate():void
		{
			hotkey = new CharHotkey("@", [HotkeyModifier.COMMAND, HotkeyModifier.COMMAND]);
		}
		
		[Test(expects="TypeError")]
		public function hotkey_throws_error_when_supplied_os_type_is_not_valid():void
		{
			hotkey = new CharHotkey("@", null, [new Object()]);
		}
		
		[Test(expects="ArgumentError")]
		public function hotkey_throws_error_when_supplied_os_type_is_duplicate():void
		{
			hotkey = new CharHotkey("@", null, [OSType.MAC, OSType.MAC]);
		}
		
		[Test]
		public function execute_dispatches_executed_signal():void
		{
			hotkey = new CharHotkey("@");
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			hotkey.execute();
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function hotkey_to_string_returns_char():void
		{
			hotkey = new CharHotkey("@", null, [OSType.MAC]);
			
			assertThat(hotkey.toString(), equalTo("@"));
		}
		
		[Test]
		public function hotkey_with_modifier_to_string_returns_modifier_plus_char():void
		{
			hotkey = new CharHotkey("@", [HotkeyModifier.COMMAND], [OSType.MAC]);
			
			assertThat(hotkey.toString(), equalTo("command+@"));
		}
		
		[Test]
		public function hotkey_with_multiple_modifiers_to_string_returns_modifiers_plus_char():void
		{
			hotkey = new CharHotkey("@", [HotkeyModifier.COMMAND, HotkeyModifier.CONTROL], [OSType.MAC]);
			
			assertThat(hotkey.toString(), equalTo("command+control+@"));
		}
		
		[Test]
		public function hotkey_with_unsorted_modifiers_to_string_returns_sorted_modifiers_plus_char():void
		{
			hotkey = new CharHotkey("@", [HotkeyModifier.CONTROL, HotkeyModifier.COMMAND], [OSType.MAC]);
			
			assertThat(hotkey.toString(), equalTo("command+control+@"));
		}
	}
}