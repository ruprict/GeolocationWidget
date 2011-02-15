package widgets.Geolocation.model
{
	public class Geolocation implements IGeolocation
	{
		private var _x:Number;
		private var _y:Number;
		
		public function get x():Number{
			return _x;
		}
		
		public function get y():Number{
			return _y;
		}
		
		public function Geolocation(x:Number=0.00,y:Number=0.00)
		{
			_x = x;
			_y = y;
		}
	}
}