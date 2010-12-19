package com.destroytoday.model
{
	import com.destroytoday.model.enum.OperatingSystemType;
	
	import flash.system.Capabilities;

	public class OperatingSystemModel
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
		
		public function OperatingSystemModel()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get type():OperatingSystemType
		{
			if (!_type)
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
			
			return _type;
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