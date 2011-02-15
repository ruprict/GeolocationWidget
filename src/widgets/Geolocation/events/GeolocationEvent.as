package widgets.Geolocation.events
{
	import flash.events.Event;
	
	import widgets.Geolocation.model.IGeolocation;
	
	public class GeolocationEvent extends Event
	{
		public static const LOCATION_FOUND:String = "locationFound";
		public static const LOCATION_NOT_FOUND:String = "locationNotFound";
		public static const GET_LOCATION:String = "getGeolocation";
		public var location:IGeolocation;
		
		public function GeolocationEvent(type:String)
		{
			super(type);
		}
		override public function clone():Event{
			return new GeolocationEvent(type);
		}
	}
}