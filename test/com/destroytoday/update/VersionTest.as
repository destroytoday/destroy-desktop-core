package com.destroytoday.update
{
	import org.hamcrest.assertThat;

	public class VersionTest
	{
		protected var version:Version;

		[Before]
		public function setUp():void
		{
		}

		[After]
		public function tearDown():void
		{
			version = null;
		}

		[Test(expects="Error")]
		public function version_throws_error_when_invalid():void
		{
			version = new Version('v1');
		}

		[Test(expects="Error")]
		public function version_without_minor_number_is_invalid():void
		{
			version = new Version('1');
		}

		[Test(expects="Error")]
		public function version_without_patch_number_is_invalid():void
		{
			version = new Version('1.0');
		}

		[Test(expects="Error")]
		public function version_with_invalid_special_string_is_invalid():void
		{
			version = new Version('1.0.0gm');
		}

		[Test]
		public function public_release_version_is_valid():void
		{
			version = new Version('1.0.0');
		}

		[Test]
		public function release_candidate_version_is_valid():void
		{
			version = new Version('1.0.0rc');
		}

		[Test]
		public function beta_version_is_valid():void
		{
			version = new Version('1.0.0b');
		}

		[Test]
		public function alpha_version_is_valid():void
		{
			version = new Version('1.0.0a');
		}

		[Test]
		public function additional_release_candidate_versions_are_valid():void
		{
			version = new Version('1.0.0rc2');
		}

		[Test]
		public function additional_beta_versions_are_valid():void
		{
			version = new Version('1.0.0b2');
		}

		[Test]
		public function additional_alpha_versions_are_valid():void
		{
			version = new Version('1.0.0a2');
		}
		
		[Test]
		public function public_release_version_is_public():void
		{
			version = new Version('1.0.0');
			
			assertThat(version.isPublic);
		}
		
		[Test]
		public function release_candidate_version_is_release_candidate():void
		{
			version = new Version('1.0.0rc');
			
			assertThat(version.isReleaseCandidate);
		}
		
		[Test]
		public function beta_version_is_beta():void
		{
			version = new Version('1.0.0b');
			
			assertThat(version.isBeta);
		}
		
		[Test]
		public function alpha_version_is_alpha():void
		{
			version = new Version('1.0.0a');
			
			assertThat(version.isAlpha);
		}
		
		[Test]
		public function major_version_is_newer_than_older_major_version():void
		{
			version = new Version('2.0.0');
			
			assertThat(version.isNewerThan(new Version('1.0.0')));
		}
		
		[Test]
		public function minor_version_is_newer_than_older_minor_version():void
		{
			version = new Version('1.1.0');
			
			assertThat(version.isNewerThan(new Version('1.0.0')));
		}

		[Test]
		public function patch_version_is_newer_than_older_patch_version():void
		{
			version = new Version('1.0.1');

			assertThat(version.isNewerThan(new Version('1.0.0')));
		}
		
		[Test]
		public function public_release_version_is_newer_than_release_candidate_version():void
		{
			version = new Version('1.0.0');
			
			assertThat(version.isNewerThan(new Version('1.0.0rc')));
		}
		
		[Test]
		public function release_candidate_version_is_newer_than_beta_version():void
		{
			version = new Version('1.0.0rc');
			
			assertThat(version.isNewerThan(new Version('1.0.0b')));
		}
		
		[Test]
		public function beta_version_is_newer_than_alpha_version():void
		{
			version = new Version('1.0.0b');
			
			assertThat(version.isNewerThan(new Version('1.0.0a')));
		}
	}
}