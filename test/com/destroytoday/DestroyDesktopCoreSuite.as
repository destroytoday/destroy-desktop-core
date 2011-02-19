package com.destroytoday
{
	import com.destroytoday.model.ApplicationModelTest;
	import com.destroytoday.update.UpdateTest;
	import com.destroytoday.update.VersionTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class DestroyDesktopCoreSuite
	{
		public var applicationModelTest:ApplicationModelTest;
		
		public var versionTest:VersionTest;
		public var updateTest:UpdateTest;
	}
}