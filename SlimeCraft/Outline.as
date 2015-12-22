package  {
	
	import flash.display.MovieClip;
	
	
	public class Outline extends PlayerDependent {
		
		override protected function initialize():void 
		{
			gotoAndStop(player);
		}
	}
	
}
