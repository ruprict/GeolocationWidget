package org.robotlegs.oil.utils.remote
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Actor;
	import org.robotlegs.oil.async.Promise;

	public class RemoteServiceBase extends Actor implements RemoteService
	{
		private var loaders:Dictionary;
		private var promises:Array;
		private var rootURL:String;
		
		public function RemoteServiceBase(rootURL:String = "")
		{
			this.loaders = new Dictionary();
			this.promises = new Array();
			this.rootURL = rootURL;
		}
		
		public function get(url:String):Promise
		{
			var req:URLRequest = new URLRequest(fullUrl(url));
			return request(req);
		}
		
		public function post(url:String, params:Object=null):Promise
		{
			var req:URLRequest = new URLRequest(fullUrl(url));
			var vars:URLVariables = new URLVariables();
			params ||= {forcePost:true};

			for (var prop:String in params){
				vars[prop] = params[prop];
			}
			req.data = vars;
			req.method = URLRequestMethod.POST;
			return request(req);
		}
		
		protected function request(req:URLRequest):Promise{
			var promise:Promise = new Promise();
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, createHandler(handleComplete, promise));
			loader.addEventListener(IOErrorEvent.IO_ERROR, createHandler(handleIoError, promise));
			loader.addEventListener(ProgressEvent.PROGRESS, createHandler(handleProgress, promise));
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, createHandler(handleSecurity, promise));
			promises.push(promise);
			loaders[promise] = loader;
			loader.load(req);
			return promise;
		}
		
		protected function releasePromise(promise:Promise):void{
			var index:int = promises.indexOf(promise);
			if (index != -1){
				promises.splice(index, 1);
				delete loaders[promise];
			}
		}
		
		protected function createHandler(listener:Function, promise:Promise):Function
		{
			return function(event:Event):void
			{
				listener(event, promise);
			}
		}
		
		protected function handleSecurity(e:SecurityErrorEvent, promise:Promise):void
		{
			releasePromise(promise);
			promise.handleError({error: "Security Error", message: e.text});
		}
		
		protected function handleProgress(e:ProgressEvent, promise:Promise):void
		{
			// promise.handleProgress({bytesTotal: e.bytesTotal, bytesLoaded: e.bytesLoaded});
		}
		
		protected function handleIoError(e:IOErrorEvent, promise:Promise):void
		{
			releasePromise(promise);
			promise.handleError({error: "IO Error", message: e.text});
		}
		
		protected function handleComplete(e:Event, promise:Promise):void
		{
			releasePromise(promise);
			promise.handleResult(generateObject(e.target.data));
		}
		
		protected function fullUrl(url:String):String
		{
			if (url == null || url.length == 0)
				return null;
			
			return url.indexOf("://") > -1 ? url : rootURL + url;
		}
		
		protected function generateObject(data:*):Object
		{
			return Object(data);
		}
	}
}