package widgets.Geolocation.services
{
	import com.esri.ags.FeatureSet;
	import com.esri.ags.Graphic;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.geometry.Polygon;
	import com.esri.ags.tasks.QueryTask;
	import com.esri.ags.tasks.supportClasses.Query;
	
	import mx.rpc.AsyncResponder;
	
	import org.robotlegs.mvcs.Actor;
	
	import widgets.Geolocation.events.PointInPolygonEvent;
	
	public class PointInPolygonService extends Actor implements IPointInPolygonService
	{
		
		public var queryTask:QueryTask;
		
		[Embed(source="../GeolocationWidget.xml", mimeType="text/xml")]
		public var configXML:Class;
		
		public function PointInPolygonService()
		{
			queryTask = new QueryTask(configXML.data.featureServerURL);
		}
		
		public function getPolygon(x:Number, y:Number):void
		{
			// If they didn't give us a URL, then forget about it
			if (!configXML || !configXML.data || !configXML.data.featureServerURL  ){
				trace("No URL provided for Polygon search");
				return;	
			}
			trace("Using "+configXML.data.featureServerURL);
			
			var point:MapPoint = new MapPoint(x,y);
			var query:Query = new Query();
			queryTask.useAMF=false;
			queryTask.requestTimeout = 10000;
			query.geometry=point;
			queryTask.execute(query, new AsyncResponder(handlePolygonFound,handleFault));
		}
		
		public function handlePolygonFound(featureSet:FeatureSet, token:Object=null):void
		{
			
			if (featureSet.features.length==0){
				dispatch(new PointInPolygonEvent(PointInPolygonEvent.POLYGON_NOT_FOUND));
				return;
			}
			
			var polygon:Graphic = featureSet.features[0] as Graphic;
				
			var event:PointInPolygonEvent = new PointInPolygonEvent(PointInPolygonEvent.POLYGON_FOUND,polygon);
			dispatch(event);
		}
		
		public function handleFault(error:Object, token:Object=null):void{
			trace("ERROR: Polygon not found");
			
			var event:PointInPolygonEvent = new PointInPolygonEvent(PointInPolygonEvent.POLYGON_NOT_FOUND);
			dispatch(event);
		
		}
		
		
		
	}
}