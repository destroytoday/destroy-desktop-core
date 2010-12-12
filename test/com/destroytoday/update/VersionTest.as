package com.destroytoday.update
{
	import com.destroytoday.model.enum.VersionType;
	
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
			
			assertThat(version.type, equalTo(VersionType.PUBLIC));
		}
		
		[Test]
		public function release_candidate_version_is_release_candidate():void
		{
			version = new Version('1.0.0rc');
			
			assertThat(version.type, equalTo(VersionType.RELEASE_CANDIDATE));
		}
		
		[Test]
		public function beta_version_is_beta():void
		{
			version = new Version('1.0.0b');
			
			assertThat(version.type, equalTo(VersionType.BETA));
		}
		
		[Test]
		public function alpha_version_is_alpha():void
		{
			version = new Version('1.0.0a');
			
			assertThat(version.type, equalTo(VersionType.ALPHA));
		}
		
		[Test]
		public function major_version_is_populated_upon_instantiation():void
		{
			version = new Version('1.0.0');
			
			assertThat(version.major, equalTo('1'));
		}
		
		[Test]
		public function minor_version_is_populated_upon_instantiation():void
		{
			version = new Version('1.1.0');
			
			assertThat(version.minor, equalTo('1'));
		}
		
		[Test]
		public function patch_version_is_populated_upon_instantiation():void
		{
			version = new Version('1.0.1');
			
			assertThat(version.patch, equalTo('1'));
		}
		
		[Test]
		public function special_version_is_populated_upon_instantiation():void
		{
			version = new Version('1.0.0b2');
			
			assertThat(version.special, equalTo('2'));
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
		
		[Test]
		public function double_digit_minor_version_is_newer_than_single_digit_minor_version():void
		{
			version = new Version('1.10.0');
			
			assertThat(version.isNewerThan(new Version('1.9.0')));
		}
		
		[Test]
		public function double_digit_patch_version_is_newer_than_single_digit_patch_version():void
		{
			version = new Version('1.0.10');
			
			assertThat(version.isNewerThan(new Version('1.0.9')));
		}
		
		[Test]
		public function single_digit_major_version_is_newer_than_older_double_digit_minor_version():void
		{
			version = new Version('2.0.0');
			
			assertThat(version.isNewerThan(new Version('1.10.0')));
		}
		
		[Test]
		public function double_digit_special_version_is_newer_than_single_digit_special_version():void
		{
			version = new Version('1.0.0b10');

			assertThat(version.isNewerThan(new Version('1.0.0b9')));
		}
		
		[Test]
		public function version_is_newer_than_older_double_digit_special_version():void
		{
			version = new Version('1.0.1');
			
			assertThat(version.isNewerThan(new Version('1.0.0b10')));
		}
	}
}