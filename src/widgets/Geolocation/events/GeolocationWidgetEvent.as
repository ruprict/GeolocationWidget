package widgets.Geolocation.events
{
	import flash.events.Event;
	
	import widgets.Geolocation.GeolocationWidget;
	
	public class GeolocationWidgetEvent extends Event
	{
		public static const CLOSED:String = "closed";
		public static const OPEN:String = "open";
		
		public function GeolocationWidgetEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event{
			
			return new GeolocationWidgetEvent(type);
		}
	}
}