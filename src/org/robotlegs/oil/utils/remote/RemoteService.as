package org.robotlegs.oil.utils.remote
{
	import org.robotlegs.oil.async.Promise;

	public interface RemoteService
	{
		function get(url:String):Promise;
		function post(url:String, params:Object = null):Promise;
	}
}