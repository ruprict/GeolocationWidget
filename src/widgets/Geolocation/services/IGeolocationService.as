package widgets.Geolocation.services
{
	public interface IGeolocationService
	{
		function getGeolocation():void;
		function handleLocationFound(x:Number, y:Number):void;
		function handleLocationNotFound():void;
	}
}