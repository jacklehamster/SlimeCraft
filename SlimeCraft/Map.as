package  {
	import flash.geom.Rectangle;
	
	public class Map {

		public function GetElements(rect:Rectangle):Vector.<MapElement> {
			var elements:Vector.<MapElement> = new Vector.<MapElement>();
			for(var y:int = Math.floor(rect.top); y < rect.bottom; y++) {
				for(var x:int = Math.floor(rect.left); x < rect.right; x++) {
					RetrieveElements(x,y,elements);
				}
			}
			return elements;
		}
		
		protected function RetrieveElements(x:int, y:int, elements:Vector.<MapElement>):void {
			
		}
	}
	
}
