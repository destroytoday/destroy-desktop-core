package com.destroytoday.service
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class URLService implements IURLService
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function URLService()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function openURL(url:String):void
		{
			navigateToURL(new URLRequest(url));
		}
	}
}