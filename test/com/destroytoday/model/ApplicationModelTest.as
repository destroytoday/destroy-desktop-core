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
		public function id_returns_application_id():void
		{
			assertThat(model.id, equalTo('FlexUnitApplication'));
		}
		
		[Test]
		public function name_returns_application_name():void
		{
			assertThat(model.name, equalTo('FlexUnitApplication'));
		}
		
		[Test]
		public function filename_returns_application_filename():void
		{
			assertThat(model.filename, equalTo('FlexUnitApplication'));
		}
		
		[Test]
		public function version_returns_application_version():void
		{
			assertThat(model.version.toString(), equalTo('1.0.0'));
		}
	}
}