package com.destroytoday.model
{
	
	import flash.desktop.NativeApplication;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class ApplicationModelTest
	{	
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var model:IApplicationModel;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
			model = new ApplicationModel();
		}
		
		[After]
		public function tearDown():void
		{
			model = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function descriptor_defaults_to_native_application_descriptor():void
		{
			assertThat(model.descriptor, equalTo(NativeApplication.nativeApplication.applicationDescriptor));
		}
		
		[Test]
		public function id_returns_application_id():void
		{
			model.descriptor = 
				<application xmlns="http://ns.adobe.com/air/application/2.5">
					<id>com.company.application</id>
				</application>;
			
			assertThat(model.id, equalTo('com.company.application'));
		}
		
		[Test]
		public function name_returns_application_name():void
		{
			model.descriptor = 
				<application xmlns="http://ns.adobe.com/air/application/2.5">
					<name>Application</name>
				</application>;
			
			assertThat(model.name, equalTo('Application'));
		}
		
		[Test]
		public function filename_returns_application_filename():void
		{
			model.descriptor = 
				<application xmlns="http://ns.adobe.com/air/application/2.5">
					<filename>Application</filename>
				</application>;
			
			assertThat(model.filename, equalTo('Application'));
		}
		
		[Test]
		public function version_returns_air_2_5_application_version_label():void
		{
			model.descriptor = 
				<application xmlns="http://ns.adobe.com/air/application/2.5">
					<versionLabel>1.0.0rc</versionLabel>
				</application>;
			
			assertThat(model.version.toString(), equalTo('1.0.0rc'));
		}
		
		[Test]
		public function version_returns_air_2_5_application_version_number():void
		{
			model.descriptor = 
				<application xmlns="http://ns.adobe.com/air/application/2.5">
					<versionNumber>1.0.0</versionNumber>
				</application>;
			
			assertThat(model.version.toString(), equalTo('1.0.0'));
		}
		
		[Test]
		public function version_returns_label_over_number():void
		{
			model.descriptor = 
				<application xmlns="http://ns.adobe.com/air/application/2.5">
					<versionLabel>1.0.0rc</versionLabel>
					<versionNumber>1.0.0</versionNumber>
				</application>;
			
			assertThat(model.version.toString(), equalTo('1.0.0rc'));
		}
		
		[Test]
		public function version_returns_air_2_0_application_version():void
		{
			model.descriptor = 
				<application xmlns="http://ns.adobe.com/air/application/2.5">
					<version>1.0.0</version>
				</application>;
			
			assertThat(model.version.toString(), equalTo('1.0.0'));
		}
		
		[Test]
		public function url_returns_application_url():void
		{
			model.descriptor = 
				<application xmlns="http://ns.adobe.com/air/application/2.5">
					<url>http://application.com</url>
				</application>;
			
			assertThat(model.url, equalTo('http://application.com'));
		}
	}
}