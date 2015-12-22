package  {
	
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	
	public class Coverer extends MC {
		
		static public var BMPs:Object = {};
		
		var bmp:Bitmap;
		private var showingFrame:int = 0;
		private var showingPlayer:int = 0;
		static private var rect:Rectangle;
		
		override protected function initialize():void {
			if(!rect) {
				rect = getRect(slimo);
			}
			removeChildAt(0);
			bmp = new Bitmap();
			addChild(bmp);
		}
		
		private function get slimo():Slimo {
			return Slimo(parent);
		}
		
		private function setFilteredVisible(value:Boolean):void {
			for(var i:int = 0; i < slimo.numChildren; i++) {
				var child:DisplayObject = slimo.getChildAt(i);
				if(child != this && child != slimo.progressbar) {
					child.visible = value;
				}
			}
		}
		
		override protected function refresh():void {
			
			var frame:int = slimo.currentFrame;
			if(frame!=showingFrame || slimo.player!=showingPlayer) {
				if(!BMPs[frame+"_"+slimo.player]) {
					var colorFilters:Array = slimo.player==0 ? [] : Swappers.Instance["player"+slimo.player+"Filter"].filters;
					var bitmapData:BitmapData = new BitmapData(rect.width/scaleX, rect.height/scaleY,true,0);
					visible = false;
					setFilteredVisible(true);
					bitmapData.draw(slimo,new Matrix(1/scaleX,0,0,1/scaleY,-rect.left/scaleX,-rect.top/scaleY),null,null,null,true);
					if(colorFilters[0])
						bitmapData.applyFilter(bitmapData,bitmapData.rect,new Point(),colorFilters[0]);
					visible = true;
					BMPs[frame+"_"+slimo.player] = bitmapData;
				}
				bmp.bitmapData =BMPs[frame+"_"+slimo.player];
				showingFrame = frame;
				showingPlayer = slimo.player;
				setFilteredVisible(false);
			}
		}
	}
	
}
