package com.destroytoday.environment
{
	import com.destroytoday.model.enum.OSType;
	
	import flash.system.Capabilities;

	public class OS
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _type:OSType;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function OS()
		{
			populateType();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get type():OSType
		{
			return _type;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function populateType():void
		{
			var os:String = Capabilities.os.toLowerCase();
			
			if (os.indexOf('mac os') != -1)
			{
				_type = OSType.MAC;
			}
			else if (os.indexOf('windows') != -1)
			{
				_type = OSType.WINDOWS;
			}
			else if (os.indexOf('linux') != -1)
			{
				_type = OSType.LINUX;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function toString():String
		{
			return Capabilities.os;
		}
	}
}