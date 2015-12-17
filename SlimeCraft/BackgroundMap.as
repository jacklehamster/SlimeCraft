package  {
	public class BackgroundMap extends Map {

		static private var _instance:BackgroundMap;
		static public function get Instance():BackgroundMap {
			if(!_instance) {
				_instance = new BackgroundMap();
			}
			return _instance;
		}
		
		private var map:Object = {};
		override protected function RetrieveElements(x:int, y:int, elements:Vector.<MapElement>):void {
			if(!map[x+"_"+y]) {
				map[x+"_"+y] = [];
				var array:Array = RandSeedCacher.seed(x+","+y);
				if(array[0]%100==0) {
					var elem:BackgroundElement = BackgroundElement.create();
					elem.x = x;
					elem.y = y;
					elem.rotation = array[1] % 360;
					map[x+"_"+y].push(elem);
				}
			}
			elements.push.apply(null,map[x+"_"+y]);
		}
	}
	
}
