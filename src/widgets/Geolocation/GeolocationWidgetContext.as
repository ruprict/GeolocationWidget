package widgets.Geolocation
{
	import flash.display.DisplayObjectContainer;
	import flash.system.ApplicationDomain;
	
	import mx.events.ModuleEvent;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.mvcs.Context;
	import org.robotlegs.utilities.modular.mvcs.ModuleContext;
	
	import spark.components.Application;
	
	import widgets.Geolocation.commands.FindPolygonCommand;
	import widgets.Geolocation.commands.GetGeolocationCommand;
	import widgets.Geolocation.events.GeolocationEvent;
	import widgets.Geolocation.mediators.GeolocationWidgetMediator;
	import widgets.Geolocation.model.*;
	import widgets.Geolocation.services.*;
	import widgets.Geolocation.services.GeolocationService;
	import widgets.Geolocation.services.IGeolocationService;
	
	
	
	public class GeolocationWidgetContext extends ModuleContext
	{
		public function GeolocationWidgetContext(contextView:DisplayObjectContainer, injector:IInjector){
			
			super(contextView, true, injector, ApplicationDomain.currentDomain);
		}
		
		override public function startup():void{
			this.viewMap.mapType(GeolocationWidget);
			//Singletons
			injector.mapSingletonOf(IGeolocationService, GeolocationService);
			injector.mapSingletonOf(IPointInPolygonService, PointInPolygonService);
			injector.mapSingletonOf(IGeolocation,Geolocation);
			
			//Mediators
			mediatorMap.mapView(GeolocationWidget, GeolocationWidgetMediator);
		
			//Commands
			commandMap.mapEvent(GeolocationEvent.GET_LOCATION, GetGeolocationCommand,GeolocationEvent);
			commandMap.mapEvent(GeolocationEvent.LOCATION_FOUND, FindPolygonCommand, GeolocationEvent);

			
		}
		
		
	}
}
