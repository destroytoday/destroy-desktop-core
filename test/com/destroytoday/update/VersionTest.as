package com.destroytoday.update
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

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
		public function public_version_is_valid():void
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
		public function public_version_is_public():void
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
		public function public_version_to_integer_adds_public_code():void
		{
			version = new Version('1.0.0');

			assertThat(version.toInteger(), equalTo(1003));
		}
		
		[Test]
		public function release_candidate_version_to_integer_replaces_rc_with_release_candidate_code():void
		{
			version = new Version('1.0.0rc');
			
			assertThat(version.toInteger(), equalTo(1002));
		}
		
		[Test]
		public function beta_version_to_integer_replaces_b_with_beta_code():void
		{
			version = new Version('1.0.0b');
			
			assertThat(version.toInteger(), equalTo(1001));
		}
		
		[Test]
		public function alpha_version_to_integer_replaces_a_with_alpha_code():void
		{
			version = new Version('1.0.0a');
			
			assertThat(version.toInteger(), equalTo(1000));
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
		public function public_version_is_newer_than_release_candidate_version():void
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
		
		[Test]
		public function alpha_version_is_newer_than_older_beta_version():void
		{
			version = new Version('1.0.1a');
			
			assertThat(version.isNewerThan(new Version('1.0.0b')));
		}
		
		[Test]
		public function beta_version_is_newer_than_older_release_candidate_version():void
		{
			version = new Version('1.0.1b');
			
			assertThat(version.isNewerThan(new Version('1.0.0rc')));
		}
		
		[Test]
		public function release_candidate_version_is_newer_than_older_public_version():void
		{
			version = new Version('1.0.1rc');
			
			assertThat(version.isNewerThan(new Version('1.0.0')));
		}
		
		[Test]
		public function double_digit_major_version_is_newer_than_single_digit_major_version():void
		{
			version = new Version('10.0.0');
			
			assertThat(version.isNewerThan(new Version('9.0.0')));
		}
	}
}