package widgets.Geolocation.tests
{
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	
	import widgets.Geolocation.events.GeolocationEvent;
	import widgets.Geolocation.model.Geolocation;
	import widgets.Geolocation.model.IGeolocation;
	import widgets.Geolocation.services.GeolocationService;

	public class GeolocationServiceTest 
	{	
		private var service:GeolocationService;
		private var serviceDispatcher: EventDispatcher;
		
		[Before]
		public function setUp():void
		{
			serviceDispatcher = new EventDispatcher();
			service = new GeolocationService();
			service.eventDispatcher = serviceDispatcher;
		}
		
		[After]
		public function tearDown():void
		{
			serviceDispatcher = null;
			service = null;
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test(async, timeout=2000)]
		public function service_should_fire_geolocation_found_event():void {
			
			//Arrange
			serviceDispatcher.addEventListener(GeolocationEvent.LOCATION_FOUND,Async.asyncHandler(this,handleLocationFound, 2000,null,handleTimeout),false,0,true);
			//Act
			service.handleLocationFound(10.0,10.0);
			
			
		}
		
		private function handleLocationFound(event:GeolocationEvent,object:Object):void{
			//Assert
			assertThat(event.location.x,equalTo(10.0));
			assertThat(event.location.y,equalTo(10.0));
		}
		
		[Test(async, timeout=2000)]
		public function service_should_fire_geolocation_not_found_event():void {
			
			//Arrange
			serviceDispatcher.addEventListener(GeolocationEvent.LOCATION_NOT_FOUND,Async.asyncHandler(this,handleLocationNotFound, 2000,null,handleTimeout),false,0,true);
			//Act
			service.handleLocationNotFound();
			
		}
		
		private function handleLocationNotFound(event:GeolocationEvent,object:Object):void{
			//Assert
			assertThat(event.type, equalTo(GeolocationEvent.LOCATION_NOT_FOUND));
		}
		
		private function handleTimeout(object:Object):void{
			
		 	Assert.fail("Event never fired");
		}
		
		
	}
}