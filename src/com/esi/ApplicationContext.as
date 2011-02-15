package com.esi
{
	import com.esri.viewer.BaseWidget;
	
	import flash.display.DisplayObjectContainer;
	import flash.system.ApplicationDomain;
	
	import org.robotlegs.core.IInjector;
	import org.robotlegs.utilities.modular.mvcs.ModuleContext;
	
	
	public class ApplicationContext extends ModuleContext
	{
		public function ApplicationContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true, parentInjector:IInjector=null, applicationDomain:ApplicationDomain=null)
		{
			super(contextView, autoStartup, parentInjector, applicationDomain);
		}
		
		public override function startup():void {
			
			trace("ApplicationContext.Startup");
			
			viewMap.mapType(BaseWidget); 
			
		}
	}
}