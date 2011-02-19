package com.destroytoday.update
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;

	public class UpdateTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		protected const sampleDescriptor:XML = 
			<update xmlns="http://ns.adobe.com/air/framework/update/description/2.5">
				<versionLabel>2.0.0</versionLabel>
				<url>http://www.example.com/updates/application_2.0.air</url>
				<date>2/19/2011</date>
				<description>This is the latest version of the Sample application.</description>
			</update>;
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var update:Update;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[After]
		public function tearDown():void
		{
			update = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------
		// interfaces 
		//--------------------------------------
		
		[Test]
		public function update_implements_interface():void
		{
			update = new Update(sampleDescriptor);
			
			assertThat(update is IUpdate);
		}
		
		//--------------------------------------
		// descriptor 
		//--------------------------------------
		
		[Test(expects="Error")]
		public function update_fails_without_descriptor():void
		{
			update = new Update(null);
		}
		
		[Test]
		public function update_returns_string_descriptor():void
		{
			update = new Update(sampleDescriptor);
			
			assertThat(update.toString(), equalTo(sampleDescriptor.toString()));
		}
		
		//--------------------------------------
		// version 
		//--------------------------------------
		
		[Test]
		public function update_populates_version_using_version_label_upon_instantiation():void
		{
			var descriptor:XML = 
				<update xmlns="http://ns.adobe.com/air/framework/update/description/2.5">
					<versionLabel>2.0.0</versionLabel>
					<url>http://www.example.com/updates/application_2.0.air</url>
					<date>2/19/2011</date>
					<description>This is the latest version of the Sample application.</description>
				</update>;
			
			update = new Update(descriptor);
			
			assertThat(update.version.toString(), equalTo('2.0.0'));
		}
		
		[Test]
		public function update_populates_version_using_version_number_upon_instantiation():void
		{
			var descriptor:XML = 
				<update xmlns="http://ns.adobe.com/air/framework/update/description/2.5">
					<versionNumber>2.0.0</versionNumber>
					<url>http://www.example.com/updates/application_2.0.air</url>
					<date>2/19/2011</date>
					<description>This is the latest version of the Sample application.</description>
				</update>;
			
			update = new Update(descriptor);
		}
		
		[Test]
		public function update_populates_version_using_version_upon_instantiation():void
		{
			var descriptor:XML = 
				<update xmlns="http://ns.adobe.com/air/framework/update/description/2.0">
					<version>2.0.0</version>
					<url>http://www.example.com/updates/application_2.0.air</url>
					<date>2/19/2011</date>
					<description>This is the latest version of the Sample application.</description>
				</update>;
			
			update = new Update(descriptor);
		}
		
		[Test(expects="Error")]
		public function update_fails_without_version():void
		{
			var descriptor:XML = 
				<update xmlns="http://ns.adobe.com/air/framework/update/description/2.5">
					<url>http://www.example.com/updates/application_2.0.air</url>
					<date>2/19/2011</date>
					<description>This is the latest version of the Sample application.</description>
				</update>;
			
			update = new Update(descriptor);
		}
		
		//--------------------------------------
		// date 
		//--------------------------------------
		
		[Test]
		public function update_populates_date_upon_instantiation():void
		{
			update = new Update(sampleDescriptor);
			
			assertThat(update.date.toString(), equalTo(new Date('2/19/2011').toString()));
		}
		
		[Test(expects="Error")]
		public function update_fails_without_date():void
		{
			var descriptor:XML = 
				<update xmlns="http://ns.adobe.com/air/framework/update/description/2.5">
					<versionLabel>2.0.0</versionLabel>
					<url>http://www.example.com/updates/application_2.0.air</url>
					<description>This is the latest version of the Sample application.</description>
				</update>;
			
			update = new Update(descriptor);
		}
		
		//--------------------------------------
		// url 
		//--------------------------------------
		
		[Test]
		public function update_populates_url_upon_instantiation():void
		{
			update = new Update(sampleDescriptor);
			
			assertThat(update.url, equalTo('http://www.example.com/updates/application_2.0.air'));
		}
		
		[Test(expects="Error")]
		public function update_fails_without_url():void
		{
			var descriptor:XML = 
				<update xmlns="http://ns.adobe.com/air/framework/update/description/2.5">
					<versionLabel>2.0.0</versionLabel>
					<date>2/19/2011</date>
					<description>This is the latest version of the Sample application.</description>
				</update>;
			
			update = new Update(descriptor);
		}
		
		//--------------------------------------
		// description 
		//--------------------------------------
		
		[Test]
		public function update_populates_description_upon_instantiation():void
		{
			update = new Update(sampleDescriptor);
			
			assertThat(update.description, equalTo('This is the latest version of the Sample application.'));
		}
		
		[Test(expects="Error")]
		public function update_fails_without_description():void
		{
			var descriptor:XML = 
				<update xmlns="http://ns.adobe.com/air/framework/update/description/2.5">
					<versionLabel>2.0.0</versionLabel>
					<url>http://www.example.com/updates/application_2.0.air</url>
					<date>2/19/2011</date>
				</update>;
			
			update = new Update(descriptor);
		}
	}
}