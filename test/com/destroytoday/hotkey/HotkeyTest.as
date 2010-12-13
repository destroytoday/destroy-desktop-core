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

	public class HotkeyTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var hotkey:Hotkey;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before(async, timeout=5000)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(Signal), Event.COMPLETE);
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
		public function hotkey_populates_key_when_argument_is_string():void
		{
			hotkey = new Hotkey("A");
			
			assertThat(hotkey.key, equalTo("A"));
		}
		
		[Test]
		public function hotkey_populates_keyCode_when_argument_is_uint():void
		{
			hotkey = new Hotkey(Keyboard.A);
			
			assertThat(hotkey.keyCode, equalTo(Keyboard.A));
		}
		
		[Test]
		public function hotkey_populates_modifierList_with_constructor_argument():void
		{
			var modifierList:Array = [HotkeyModifier.COMMAND];
			
			hotkey = new Hotkey("A", modifierList);
			
			assertThat(hotkey.modifierList, strictlyEqualTo(modifierList));
		}
		
		[Test]
		public function hotkey_populates_osList_with_constructor_argument():void
		{
			var osList:Array = [OSType.MAC];
			
			hotkey = new Hotkey("A", null, osList);
			
			assertThat(hotkey.osList, strictlyEqualTo(osList));
		}
		
		[Test]
		public function hotkey_sorts_modifierList_when_set():void
		{
			var modifierList:Array = [HotkeyModifier.SHIFT, HotkeyModifier.CONTROL];
			var sortedModifierList:Array = modifierList.concat().sort();
			
			hotkey = new Hotkey("A", modifierList);
			
			assertThat(hotkey.modifierList, equalTo(sortedModifierList));
		}
		
		[Test]
		public function hotkey_nullifies_keyCode_when_key_is_set():void
		{
			hotkey = new Hotkey(Keyboard.A);
			
			hotkey.key = "A";
			
			assertThat(hotkey.keyCode, equalTo(-1));
		}
		
		[Test]
		public function hotkey_nullifies_key_when_keyCode_is_set():void
		{
			hotkey = new Hotkey("A");
			
			hotkey.keyCode = Keyboard.A;
			
			assertThat(hotkey.key, nullValue());
		}
		
		[Test(expects="ArgumentError")]
		public function hotkey_throws_error_when_key_is_not_uint_or_string():void
		{
			hotkey = new Hotkey(new Object());
		}
		
		[Test]
		public function execute_dispatches_executed_signal():void
		{
			hotkey = new Hotkey("A");
			hotkey.executed = strict(Signal);
			
			mock(hotkey.executed).method('dispatch').once();
			hotkey.execute();
			
			verify(hotkey.executed);
		}
		
		[Test]
		public function hotkey_to_string_returns_hotkey_summary():void
		{
			hotkey = new Hotkey("a", [HotkeyModifier.COMMAND, HotkeyModifier.SHIFT], [OSType.MAC]);
			
			assertThat(hotkey.toString(), equalTo("command + shift + a"));
		}
	}
}