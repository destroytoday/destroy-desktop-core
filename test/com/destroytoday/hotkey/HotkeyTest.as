package com.destroytoday.hotkey
{
	import flash.ui.Keyboard;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

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
		
		[Before]
		public function setUp():void
		{
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
		public function hotkey_implements_interface():void
		{
			hotkey = new Hotkey("@");
			
			assertThat(hotkey is IHotkey);
		}
		
		[Test]
		public function hotkey_char_combination_to_string_is_char():void
		{
			hotkey = new Hotkey("@");
			
			assertThat(hotkey.combination, equalTo("@"));
		}
		
		[Test]
		public function hotkey_modifier_char_combination_to_string_is_modifier_char():void
		{
			hotkey = new Hotkey("command+@");
			
			assertThat(hotkey.combination, equalTo("command+@"));
		}
		
		[Test]
		public function hotkey_keycode_combination_to_string_is_keycode():void
		{
			hotkey = new Hotkey(Keyboard.A);
			
			assertThat(hotkey.combination, equalTo("65"));
		}
		
		[Test]
		public function hotkey_modifier_keycode_combination_to_string_is_modifier_keycode():void
		{
			hotkey = new Hotkey("command+" + Keyboard.A);
			
			assertThat(hotkey.combination, equalTo("command+65"));
		}
		
		[Test]
		public function hotkey_sorts_modifiers_on_importance():void
		{
			hotkey = new Hotkey("shift+alt+command+control+" + Keyboard.A);
			
			assertThat(hotkey.combination, equalTo("command+control+alt+shift+65"));
		}
		
		[Test(expects="ArgumentError")]
		public function hotkey_throws_error_when_combination_is_invalid():void
		{
			hotkey = new Hotkey("fail");
		}
		
		[Test(expects="ArgumentError")]
		public function hotkey_throws_error_when_char_combination_has_shift_modifier():void
		{
			hotkey = new Hotkey("shift+@");
		}
		
		[Test(expects="ArgumentError")]
		public function hotkey_throws_error_when_char_combination_has_alt_modifier():void
		{
			hotkey = new Hotkey("alt+@");
		}
		
		[Test(expects="ArgumentError")]
		public function hotkey_throws_error_when_combination_has_multiple_chars():void
		{
			hotkey = new Hotkey("ab");
		}
	}
}