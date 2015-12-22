package  {
	import flash.display.DisplayObject;
	
	public class PlayerDependent extends MC 
		implements IPlayerDependent
	{

		public function get player():int {
			var p:DisplayObject = parent;
			while(p) {
				if(p is IPlayerDependent) {
					return (p as IPlayerDependent).player;
				}
				p = p.parent;
			}
			return 0;
		}
		
		public function get playerSetting():PlayerSetting {
			return PlayerSetting.GetSetting(player);
		}
	}
	
}
