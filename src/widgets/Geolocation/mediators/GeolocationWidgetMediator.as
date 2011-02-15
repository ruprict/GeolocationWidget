package widgets.Geolocation.mediators
{
	import com.esri.ags.Graphic;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.layers.GraphicsLayer;
	import com.esri.ags.symbols.PictureMarkerSymbol;
	import com.esri.ags.symbols.SimpleMarkerSymbol;
	import com.esri.ags.utils.WebMercatorUtil;
	import com.esri.viewer.AppEvent;
	import com.esri.viewer.ViewerContainer;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	
	import org.as3commons.reflect.Type;
	import org.robotlegs.utilities.modular.mvcs.ModuleMediator;
	
	import spark.components.Button;
	
	import widgets.Geolocation.GeolocationWidget;
	import widgets.Geolocation.TokenUtil;
	import widgets.Geolocation.events.GeolocationEvent;
	import widgets.Geolocation.events.GeolocationWidgetEvent;
	import widgets.Geolocation.events.PointInPolygonEvent;
	import widgets.Geolocation.model.Geolocation;
	import widgets.Geolocation.model.IGeolocation;
	
	public class GeolocationWidgetMediator extends ModuleMediator
	{
		[Inject]
		public var location:IGeolocation;
		
		[Inject]
		public var widget:GeolocationWidget;
		
		public var graphicsLayer:GraphicsLayer;
		
		public function GeolocationWidgetMediator(){
			
			super();
			
		}
		
		override public function onRegister():void{
			
			this.addContextListener(GeolocationEvent.LOCATION_FOUND, handleLocationFound);
			this.addViewListener(MouseEvent.CLICK, handleGoThere);
			this.addViewListener(GeolocationWidgetEvent.CLOSED,handleClose);
			this.addViewListener(GeolocationWidgetEvent.OPEN,handleOpen);
			this.addContextListener(PointInPolygonEvent.POLYGON_FOUND,handlePolygonFound);
			widget.currentState = GeolocationWidget.STATE_SEARCHING_FOR_LOCATION;
			getLocation();
		}
		
		private function getLocation():void{
			
			//Find yourself
			dispatch(new GeolocationEvent(GeolocationEvent.GET_LOCATION));
			
		}
		
		public function handleClose(event:GeolocationWidgetEvent):void{
			
			if (graphicsLayer){
				graphicsLayer.setVisible(false);
			}
			
		}
		
		public function handleOpen(event:GeolocationWidgetEvent):void{
			
			if (graphicsLayer){
				graphicsLayer.setVisible(true);
			}
			
		}
		
		public function handleLocationFound(event:GeolocationEvent):void{
			widget.currentState = GeolocationWidget.STATE_LOCATION_FOUND;
			location = event.location;
			widget.loc_x.text=location.x.toString();
			widget.loc_y.text=location.y.toString();
			
		}
		
		public function handleLocationNotFound(event:GeolocationEvent):void{
			
			widget.currentState = GeolocationWidget.STATE_LOCATION_NOT_FOUND;
			
		}
		public function handlePolygonFound(event:PointInPolygonEvent):void{
			setPolygonInfo(event.polygon.attributes);
		}
		public function setPolygonInfo(attributes:Object):void{
			
			widget.polygonInformationLabel.text = TokenUtil.replaceTokens(widget.configXML.featureFoundTemplate,attributes,"",TokenUtil.BRACKET_PATTERN);
			
		}
		
		private function handleGoThere(event:MouseEvent):void{ 
			if (Type.forInstance(event.target)!=Type.forClass(Button))
				return;
			var x:Number = Number(widget.loc_x.text);
			var y:Number = Number(widget.loc_y.text);
			var point:MapPoint = com.esri.ags.utils.WebMercatorUtil.geographicToWebMercator(new MapPoint(x,y)) as MapPoint;

			widget.map.centerAt(point);
			addGraphic(point);
			
		}
		
		private function addGraphic(point:MapPoint):void{
			var imageURL:String = widget.configXML.pushPinImageURL;
			var symbol:PictureMarkerSymbol = new PictureMarkerSymbol(imageURL);
			var graphic:Graphic = new Graphic(point,symbol);
			
			if (graphicsLayer==null){
				
				createAndAddGraphicsLayer();
				
			}
			graphicsLayer.clear();
			graphicsLayer.visible = true;
			graphicsLayer.add(graphic);
		}
		
		private function createAndAddGraphicsLayer():void{
			graphicsLayer = new GraphicsLayer();
			widget.map.addLayer(graphicsLayer);
			
		}
		
		
	}
}