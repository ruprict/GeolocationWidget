package widgets.Geolocation.services
{
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.utils.describeType;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Actor;
	
	import widgets.Geolocation.events.GeolocationEvent;
	import widgets.Geolocation.model.Geolocation;

	public class GeolocationService extends Actor implements IGeolocationService
	{
		public function GeolocationService()
		{
			ExternalInterface.addCallback("handleLocationFound",handleLocationFound);
			ExternalInterface.addCallback("handleLocationNotFound",handleLocationNotFound);
			 
		} 
		
		public function getGeolocation():void
		{
			ExternalInterface.call("esiGeo.getGeolocation");
			
			
		}
		public function handleLocationFound(x:Number, y:Number):void{
			var location:Geolocation = new Geolocation(x,y);
			var event:GeolocationEvent = new GeolocationEvent(GeolocationEvent.LOCATION_FOUND);
			event.location = location;
			dispatch(event);
		}
		
		public function handleLocationNotFound():void{
			var event:GeolocationEvent = new GeolocationEvent(GeolocationEvent.LOCATION_NOT_FOUND);
			dispatch(event);
		}
	}
}