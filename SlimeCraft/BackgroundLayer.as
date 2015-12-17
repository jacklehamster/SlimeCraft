package  {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	public class BackgroundLayer extends Layer {
		
		private var _oldPosition:Point = new Point(), _oldZoom:Number = 0;
		
		
		public function get top():TopGroundLayer {
			return topground as TopGroundLayer;
		}
		
		public function get bottom():ShadowLayer {
			return shadow as ShadowLayer;
		}
		
		private function addBackground(bg:BackgroundElement):void {
			var child:BackgroundPlatform = top.getChildByName(bg.id) as BackgroundPlatform;
			if(!child) {
				child = new BackgroundPlatform();
				child.name = bg.id;
				child.rotation = bg.rotation;
				top.addChild(child);
			}
			child.x = (bg.x - position.x)*20*.1/zoom;
			child.y = (bg.y - position.y)*20*.1/zoom;
			child.scaleX = child.scaleY = .1/zoom;
		}
		
		private function addShadow(bg:BackgroundElement):void {
			var child:ShadowPlatform = bottom.getChildByName(bg.id) as ShadowPlatform;
			if(!child) {
				child = new ShadowPlatform();
				child.name = bg.id;
				child.rotation = bg.rotation;
				bottom.addChild(child);
			}
			child.x = (bg.x - position.x)*20*.1/zoom;
			child.y = ((bg.y - position.y)*20 + 5)*.1/zoom;
			child.scaleX = child.scaleY = .1/zoom;
		}
		
		private function cleanBackground(addedElems:Object):void {
			for(var i:int = top.numChildren-1; i>=0; i--) {
				var child:BackgroundPlatform = top.getChildAt(i) as BackgroundPlatform;
				if(child && !addedElems[child.name]) {
					top.removeChildAt(i);
				}
			}
		}
		
		private function cleanShadow(addedElems:Object):void {
			for(var i:int = bottom.numChildren-1; i>=0; i--) {
				var child:ShadowPlatform = bottom.getChildAt(i) as ShadowPlatform;
				if(child && !addedElems[child.name]) {
					bottom.removeChildAt(i);
				}
			}
		}
		
		override protected function refresh():void {
			var pos:Point = position;
			if(_oldPosition.equals(pos) && _oldZoom == zoom) {
				return;
			}
			_oldPosition.setTo(pos.x, pos.y);
			_oldZoom = zoom;

			var bgMap:BackgroundMap = BackgroundMap.Instance;
			var rect:Rectangle = new Rectangle();
			rect.x = position.x - 5/zoom/10;
			rect.y = position.y - 5/zoom/10;
			rect.width = coverageWidth() + 10/zoom/10;
			rect.height = coverageHeight() + 10/zoom/10;
			var elements:Vector.<MapElement> = bgMap.GetElements(rect);
			
			var addedElems:Object = {};
			for each(var bg:BackgroundElement in elements) {
				addedElems[bg.id] = true;
				addBackground(bg);
				addShadow(bg);
//				BackgroundElement.destroy(bg);
			}
			cleanBackground(addedElems);
			cleanShadow(addedElems);
		}
	}
}
