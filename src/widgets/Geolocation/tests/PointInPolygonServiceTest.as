package widgets.Geolocation.tests
{
	import asmock.framework.Expect;
	import asmock.framework.MockError;
	import asmock.framework.MockRepository;
	import asmock.framework.SetupResult;
	
	import com.esri.ags.FeatureSet;
	import com.esri.ags.Graphic;
	import com.esri.ags.events.QueryEvent;
	import com.esri.ags.geometry.Polygon;
	import com.esri.ags.tasks.QueryTask;
	import com.esri.ags.tasks.supportClasses.Query;
	
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	
	import widgets.Geolocation.events.PointInPolygonEvent;
	import widgets.Geolocation.services.PointInPolygonService;

	[RunWith("asmock.integration.flexunit.ASMockClassRunner")]
	public class PointInPolygonServiceTest
	{		
		private var serviceDispatcher:EventDispatcher;
		private var service:PointInPolygonService;
		private var mockery:MockRepository;
		private var task:QueryTask;
		
		[Mock] public static var withMocks:Array =[
			QueryTask,
			Query
		];
		
		[Before]
		public function setUp():void
		{
			serviceDispatcher = new EventDispatcher();
			service = new PointInPolygonService();
			service.eventDispatcher = serviceDispatcher;
			mockery = new MockRepository();
			
			
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
		public function service_should_execute_task():void{
			
			//Arrange
			var query:Query = mockery.createStub(Query) as Query;
			task = (QueryTask) (mockery.createStub(QueryTask));
			service.queryTask=task;
			var token:AsyncToken = new AsyncToken();
			SetupResult.forCall(task.execute(query)).returnValue((token));
			mockery.replayAll();
			//Act
			service.getPolygon(10.0,10.0);
			//Assert
			mockery.verifyAll();
			
		}
		
		[Test]
		public function service_should_not_execute_task_if_featureServerURL_is_not_provided():void{
			
			//Arrange
			var query:Query = mockery.createStub(Query) as Query;
			task = (QueryTask) (mockery.createStub(QueryTask));
			service.queryTask=task;
			service.configXML=null;
			Expect.notCalled(task.execute(query));
			mockery.replayAll();
			//Act
			service.getPolygon(10.0,10.0);
			//Assert
			mockery.verifyAll();
		}
		
		[Test(async)]
		public function service_should_dispatch_p_in_p_event_when_polygon_found():void{
			
			//Arrange
			var event:QueryEvent = new QueryEvent(QueryEvent.EXECUTE_COMPLETE);
			serviceDispatcher.addEventListener(PointInPolygonEvent.POLYGON_FOUND,Async.asyncHandler(this,handlePolygonFound, 2000,null,handleTimeout),false,0,true);
			var featureSet:FeatureSet = new FeatureSet();
			featureSet.features = new Array();
			featureSet.features.push(new Graphic());
			
			//Act
			service.handlePolygonFound(featureSet);
			
			
			//Assert
			
		}
		
		[Test(async)]
		public function service_should_dispatch_p_in_p_not_found_event_when_polygon_not_found():void{
			
			//Arrange
			var event:QueryEvent = new QueryEvent(QueryEvent.EXECUTE_COMPLETE);
			serviceDispatcher.addEventListener(PointInPolygonEvent.POLYGON_NOT_FOUND,Async.asyncHandler(this,handlePolygonNotFound, 2000,null,handleTimeout),false,0,true);
			var featureSet:FeatureSet = new FeatureSet();
			featureSet.features = new Array();
			
			//Act
			service.handlePolygonFound(featureSet);
			
			
			//Assert
			
		}
		//private
		
		private function handlePolygonFound(event:PointInPolygonEvent,object:Object):void{
			//Assert
			assertThat(event.type, equalTo(PointInPolygonEvent.POLYGON_FOUND));
		}
		
		private function handlePolygonNotFound(event:PointInPolygonEvent,object:Object):void{
			//Assert
			assertThat(event.type, equalTo(PointInPolygonEvent.POLYGON_NOT_FOUND));
		}
		
		private function handleTimeout(object:Object):void{
			
			Assert.fail("Event never fired");
		}
		
		
	}
}