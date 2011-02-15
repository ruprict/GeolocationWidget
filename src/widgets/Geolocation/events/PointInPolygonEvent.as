package widgets.Geolocation.events
{
	import com.esri.ags.Graphic;
	import com.esri.ags.geometry.Polygon;
	
	import flash.events.Event;
	
	public class PointInPolygonEvent extends Event
	{
		public static const POLYGON_FOUND:String = "polygonFound";
		public static const POLYGON_NOT_FOUND:String = "polygonNotFound";
		public var polygon:Graphic;
		
		public function PointInPolygonEvent(type:String, poly:Graphic = null)
		{
			super(type);
			polygon=poly;
		}
		
		override public function clone():Event{
			return new PointInPolygonEvent(type,polygon);
		}
	}
}