package widgets.Geolocation.services
{
	import com.esri.ags.FeatureSet;

	public interface IPointInPolygonService
	{
		function getPolygon(x:Number, y:Number):void;
		function handlePolygonFound(featureSet:FeatureSet,token:Object = null):void;
	}
}