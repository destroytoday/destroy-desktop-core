package com.destroytoday.support
{
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	
	public class ActiveNativeWindow extends NativeWindow
	{
		public function ActiveNativeWindow()
		{
			super(new NativeWindowInitOptions());
			
			activate();
		}
	}
}