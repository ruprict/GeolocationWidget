package widgets.Geolocation.tests
{
	import asmock.framework.Expect;
	import asmock.framework.MockRepository;
	
	import com.esi.ApplicationContext;
	import com.esri.ags.Map;
	import com.esri.ags.layers.GraphicsLayer;
	import com.esri.viewer.AppEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import flashx.textLayout.debug.assert;
	
	import flexunit.framework.Assert;
	
	import mx.events.FlexEvent;
	
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import org.robotlegs.core.IInjector;
	import org.swiftsuspenders.Injector;
	
	import spark.components.Label;
	
	import widgets.Geolocation.GeolocationWidget;
	import widgets.Geolocation.GeolocationWidgetContext;
	import widgets.Geolocation.events.GeolocationEvent;
	import widgets.Geolocation.events.GeolocationWidgetEvent;
	import widgets.Geolocation.mediators.GeolocationWidgetMediator;
	import widgets.Geolocation.model.Geolocation;
	
	[RunWith("asmock.integration.flexunit.ASMockClassRunner")]
	public class GeolocationWidgetMediatorTest
	{		
		private var med:GeolocationWidgetMediator;
		private var wid:GeolocationWidget;
		
		[Mock] 	public static var withMocks:Array=[
			GraphicsLayer
		];
		
		
		[Before]
		public function setUp():void
		{
			wid = new GeolocationWidget();
			med = new GeolocationWidgetMediator();
			med.contextView=wid;
			med.setViewComponent(wid);
			med.widget=wid;
			med.widget.loc_x = new Label();
			med.widget.loc_y = new Label();
			med.widget.polygonInformationLabel = new Label();
			med.eventDispatcher = new EventDispatcher();
		}
		
		[After]
		public function tearDown():void
		{
			med = null;
			wid = null;
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test()]
		public function should_set_location_model_when_location_found_event_fires():void{
			
			//Arrange
			var event:GeolocationEvent = new GeolocationEvent(GeolocationEvent.LOCATION_FOUND);
			
			var loc:Geolocation = new Geolocation(10,20);
			event.location=loc;
			
			med.onRegister();
			//Act
			med.eventDispatcher.dispatchEvent(event);
			//Assert
			assertThat(med.location,equalTo(loc));
			
		}
		
		[Test()]
		public function handling_location_found_should_change_widget_state_to_location_found():void{
			//Arrange
			var event:GeolocationEvent = new GeolocationEvent(GeolocationEvent.LOCATION_FOUND);
			var loc:Geolocation = new Geolocation(10,20);
			event.location=loc; 
			
			//Act
			med.handleLocationFound(event);
			
			//Assert
			assertThat(med.widget.currentState, equalTo(GeolocationWidget.STATE_LOCATION_FOUND));
			
		}
		
		[Test()]
		public function handling_location_not_found_should_change_widget_state_to_location_not_found():void{
			//Arrange
			var event:GeolocationEvent = new GeolocationEvent(GeolocationEvent.LOCATION_FOUND);
			//Act
			med.handleLocationNotFound(event);
			
			//Assert
			assertThat(med.widget.currentState, equalTo(GeolocationWidget.STATE_LOCATION_NOT_FOUND));
		}
		[Test]
		public function set_polygon_information_should_change_polygon_widget_label():void{
			//Arrange
			var config:XML= <configuration>
						    <pushPinImageURL>assets/images/down.png</pushPinImageURL>
						    <featureServerURL>http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3</featureServerURL>
						    <featureFoundTemplate>You are in $[NAME] county. </featureFoundTemplate>						
						</configuration>;
			med.widget.configXML=config;
			//Act
			med.setPolygonInfo({NAME:"TestName"});
			//Assert
			assertThat(med.widget.polygonInformationLabel.text, equalTo("You are in TestName county."));
		
		}
		
		[Test]
		public function close_should_make_graphics_layer_invisible():void{
			
			//Arrange
			var mockery:MockRepository = new MockRepository();
			var layer:GraphicsLayer = (GraphicsLayer)(mockery.createStub(GraphicsLayer));
			med.graphicsLayer = layer;
			Expect.call(layer.setVisible(false));
			mockery.replay(layer);
			var event:GeolocationWidgetEvent = new GeolocationWidgetEvent(GeolocationWidgetEvent.CLOSED);
			//Act
			med.handleClose(event);
			//Assert
			mockery.verify(layer);
			
			
		}
		
		[Test]
		public function open_should_make_graphics_layer_invisible():void{
			
			//Arrange
			var mockery:MockRepository = new MockRepository();
			var layer:GraphicsLayer = (GraphicsLayer)(mockery.createStub(GraphicsLayer));
			med.graphicsLayer = layer;
			Expect.call(layer.setVisible(true));
			mockery.replay(layer);
			var event:GeolocationWidgetEvent = new GeolocationWidgetEvent(GeolocationWidgetEvent.CLOSED);
			//Act
			med.handleOpen(event);
			//Assert
			mockery.verify(layer);
			
			
		}
		
		
	}
}