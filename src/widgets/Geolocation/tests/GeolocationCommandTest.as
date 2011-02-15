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
	
	import widgets.Geolocation.commands.GetGeolocationCommand;
	import widgets.Geolocation.events.GeolocationEvent;
	import widgets.Geolocation.model.Geolocation;
	import widgets.Geolocation.services.IGeolocationService;
	
	[RunWith("asmock.integration.flexunit.ASMockClassRunner")]
	public class GeolocationCommandTest
	{		
		[Mock] 	public static var withMocks:Array=[
					IGeolocationService
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
			var service:IGeolocationService = (IGeolocationService)(mockery.createStub(IGeolocationService));
			Expect.call(service.getGeolocation());
			var cmd:GetGeolocationCommand = new GetGeolocationCommand();
			cmd.service= service;
			mockery.replay(service);
			//Act
			cmd.execute();
			//Assert
			mockery.verify(service);
		}
		
		
	}
}