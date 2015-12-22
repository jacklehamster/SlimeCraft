package  {
	
	import flash.display.MovieClip;
	
	
	public class OutlineSelector extends PlayerDependent {
		
		override protected function initialize():void 
		{
			gotoAndStop(player);
		}
	}
	
}
