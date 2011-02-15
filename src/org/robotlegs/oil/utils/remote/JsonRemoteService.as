package org.robotlegs.oil.utils.remote
{
	import com.adobe.serializers.json.JSONDecoder;
	
	import mx.collections.ArrayCollection;

	public class JsonRemoteService extends RemoteServiceBase
	{
		public function JsonRemoteService(rootURL:String="")
		{
			super(rootURL);
		}
		
		override protected function generateObject(data:*):Object{
			if (data=="[]")
				return new ArrayCollection();
			return new JSONDecoder().decode(String(data));
		}
	}
}