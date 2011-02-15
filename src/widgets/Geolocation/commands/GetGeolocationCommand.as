package widgets.Geolocation.commands
{
	import org.robotlegs.mvcs.Command;
	
	import widgets.Geolocation.events.GeolocationEvent;
	import widgets.Geolocation.services.IGeolocationService;
	
	public class GetGeolocationCommand extends Command
	{
		
		[Inject]
		public var service:IGeolocationService;
		
		[Inject]
		public var event:GeolocationEvent;
		
		
		public function GetGeolocationCommand()
		{
			super();
		}
		
		override public function execute():void{
			service.getGeolocation();
			
		}
	}
}