package com.destroytoday.update
{
	import com.destroytoday.model.enum.VersionType;

	public class Version
	{
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		protected static const regex:RegExp = /^([0-9]+)\.([0-9]+)\.([0-9]+)(?:(a|b|rc)([0-9]*))?$/;
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _version:String;
		
		protected var _major:int;
		
		protected var _minor:int;
		
		protected var _patch:int;
		
		protected var _type:VersionType;
		
		protected var _special:int;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function Version(version:String)
		{
			_version = version;
			
			validate();
			populate();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get major():int
		{
			return _major;
		}
		
		public function get minor():int
		{
			return _minor;
		}
		
		public function get patch():int
		{
			return _patch;
		}
		
		public function get type():VersionType
		{
			return _type;
		}
		
		public function get special():int
		{
			return _special;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function validate():void
		{
			if (!regex.test(_version))
				throw new Error("Version " + _version + " is invalid.");
		}
		
		protected function populate():void
		{
			var partList:Array = _version.match(regex);
			
			_major = int(partList[1]);
			_minor = int(partList[2]);
			_patch = int(partList[3]);
			_type = VersionType.getByAbbrev(partList[4]);
			_special = int(partList[5]);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function isNewerThan(version:Version):Boolean
		{
			return (
				_major > version.major || 
				_minor > version.minor || 
				_patch > version.patch || 
				_type.priority > version.type.priority || 
				_special > version.special
			);
		}
		
		public function toString():String
		{
			return _version;
		}
	}
}