package widgets.Geolocation.commands
{
	import org.robotlegs.mvcs.Command;
	
	import widgets.Geolocation.events.GeolocationEvent;
	import widgets.Geolocation.services.IPointInPolygonService;
	
	public class FindPolygonCommand extends Command
	{
		[Inject]
		public var service:IPointInPolygonService;
		
		[Inject]
		public var event:GeolocationEvent;
		
		public function FindPolygonCommand()
		{
			super();
		}
		
		override public function execute():void{
			service.getPolygon(event.location.x, event.location.y);
		}
	}
}