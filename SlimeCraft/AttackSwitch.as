package  {
	
	import flash.display.MovieClip;
	
	
	public class AttackSwitch extends ActionSwitch {
		
		public function get icon():MovieClip {
			return getChildByName("attackIcon") as MovieClip;
		}
	}
	
}
