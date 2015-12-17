package  {
	
	import flash.display.MovieClip;
	
	
	public class GG extends MC {
		static private var _ggs:Object = {};
		override protected function initialize():void {
			visible = false;
			_ggs[name] = this;
		}
		
		static public function Get(player:int):GG {
			return _ggs["gg"+player];
		}
	}
	
}
