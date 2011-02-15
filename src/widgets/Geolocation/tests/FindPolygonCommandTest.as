package widgets.Geolocation.tests
{
	import asmock.framework.Expect;
	import asmock.framework.MockRepository;
	
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
	import mx.rpc.AsyncToken;
	
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	
	import widgets.Geolocation.commands.FindPolygonCommand;
	import widgets.Geolocation.events.GeolocationEvent;
	import widgets.Geolocation.model.Geolocation;
	import widgets.Geolocation.services.IPointInPolygonService;
	
	[RunWith("asmock.integration.flexunit.ASMockClassRunner")]
	public class FindPolygonCommandTest
	{		
		[Mock] 	public static var withMocks:Array=[
					IPointInPolygonService
				];
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
		public function should_call_service():void
		{
			//Arrange
			var mockery:MockRepository = new MockRepository();
			var service:IPointInPolygonService = (IPointInPolygonService)(mockery.createStub(IPointInPolygonService));
			var event:GeolocationEvent = new GeolocationEvent(GeolocationEvent.LOCATION_FOUND);
			event.location=new Geolocation(10.0,10.0);
			
			Expect.call(service.getPolygon(10.0,10.0));
			var cmd:FindPolygonCommand = new FindPolygonCommand();
			cmd.service= service;
			cmd.event = event;
			mockery.replay(service);
			//Act
			cmd.execute();
			//Assert
			mockery.verify(service);
		}
		
		
	}
}