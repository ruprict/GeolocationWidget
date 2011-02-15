package widgets.Geolocation.tests
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.IsNullMatcher;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	
	import widgets.Geolocation.model.Geolocation;

	public class GeolocationTest
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function should_be_able_to_create_geolocation():void{length
			
			//Act
			var geo:Geolocation = new Geolocation(10.23, 20.33);
			
			//Assert
			assertThat(geo, notNullValue());
			assertThat(geo.x, equalTo(10.23));
			assertThat(geo.y, equalTo(20.33));
		}
		
	}
}