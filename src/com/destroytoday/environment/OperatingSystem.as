package com.destroytoday.environment
{
	import com.destroytoday.model.enum.OperatingSystemType;
	
	import flash.system.Capabilities;

	public class OperatingSystem
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _type:OperatingSystemType;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function OperatingSystem()
		{
			populateType();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get type():OperatingSystemType
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
				_type = OperatingSystemType.MAC;
			}
			else if (os.indexOf('windows') != -1)
			{
				_type = OperatingSystemType.WINDOWS;
			}
			else if (os.indexOf('linux') != -1)
			{
				_type = OperatingSystemType.LINUX;
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