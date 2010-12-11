package com.destroytoday.update
{
	public class Version
	{
		protected var _version:String;
		
		public function Version(version:String)
		{
			_version = version;
			
			validate();
		}
		
		public function validate():void
		{
			if (!/^[0-9]+\.[0-9]+\.[0-9]+(?:(?:a|b|rc)[0-9]*)?$/.test(_version))
				throw new Error("Version " + _version + " is invalid.");
		}
		
		public function get isPublic():Boolean
		{
			return !(isAlpha || isBeta || isReleaseCandidate);
		}
		
		public function get isReleaseCandidate():Boolean
		{
			return _version.indexOf('rc') != -1;
		}
		
		public function get isBeta():Boolean
		{
			return _version.indexOf('b') != -1;
		}
		
		public function get isAlpha():Boolean
		{
			return _version.indexOf('a') != -1;
		}
		
		public function isNewerThan(version:Version):Boolean
		{
			return toNumberString() > version.toNumberString();
		}
		
		public function toString():String
		{
			return _version;
		}
		
		public function toNumberString():String
		{
			var numberVersion:String = _version;
			
			if (isPublic) numberVersion += '.3';
			
			numberVersion = numberVersion.replace('a', '.0');
			numberVersion = numberVersion.replace('b', '.1');
			numberVersion = numberVersion.replace('rc', '.2');

			return numberVersion;
		}
	}
}