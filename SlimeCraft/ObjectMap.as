package  {
	import flash.utils.getTimer;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	import flash.display.MovieClip;
	
	public class ObjectMap extends Map {
		
		private var units:Object = {};
		private var maps:Object = {};
		
		public function ObjectMap():void {
			for each(var config:Array in Config.START) {
				AddUnit.apply(null,config.concat([Game.Instance.frame + Math.random()*20]));
			}
		}
		
		public function AddUnit(state:String, player:int, x:Number, y:Number, frameOrigin:int = 0):UnitElement {
			var unit:UnitElement = new UnitElement();
			unit.id = "u_" + Math.random();
			unit.state = state;
			unit.frameOrigin = frameOrigin ? frameOrigin : Game.Instance.frame;
			unit.player = player;
			unit.life = Config.LIFE[state];
			SetUnit(unit, x,y);
			return unit;
		}
		
		public function RemoveUnit(unit:UnitElement):void {
			if(maps[unit.cellID]) {
				delete maps[unit.cellID][unit.id];
			}
			delete units[unit.id];
			var player:int = unit.player;
			var unitCount:int = 0;
			for each(var u:UnitElement in units) {
				if(u.player == player) {
					unitCount++;
				}
			}
			if(!unitCount && !GG.Get(player).visible) {
				GG.Get(player).visible = true;
				Game.Instance.playerCount--;
				if(Game.Instance.playerCount==1) {
					for(var i:int = 1;i<=4;i++) {
						if(!GG.Get(i).visible) {
							GG.Get(i).visible = true;
							GG.Get(i).gotoAndStop("VICTORY");
						}
					}
					
					setTimeout(function():void {
						MovieClip(GG.Get(player).root).gotoAndPlay(1);
					},10000);
				}
			}
		}
		
		public function GetUnit(id:String):UnitElement {
			return units[id];
		}
		
		public function SetUnit(unit:UnitElement, x:Number, y:Number):void {
			if(!units[unit.id]) {
				units[unit.id] = unit;
			}
			if(!unit.bornPlace) {
				unit.bornPlace = new Point(x,y);
			}
			unit.x = x;
			unit.y = y;
			var xp:int = Math.floor(x);
			var yp:int = Math.floor(y);
			if(maps[unit.cellID]) {
				delete maps[unit.cellID][unit.id];
			}
			var cellID:String = xp+"_"+yp;
			unit.cellID = cellID;
			if(!maps[cellID]) {
				maps[cellID] = {};
			}
			maps[cellID][unit.id] = unit;
		}

		static private var _instance:ObjectMap;
		static public function get Instance():ObjectMap {
			if(!_instance) {
				_instance = new ObjectMap();
			}
			return _instance;
		}
		
		public function nextUnit(id:String, player:int):String {
			var firstUnit:String = null;
			var foundUnit:Boolean = false;
			for each(var u:UnitElement in units) {
				if(!u.selectable) {
					continue;
				}
				if(!firstUnit && u.player==player) {
					firstUnit = u.id;
				}
				if(foundUnit && u.player==player) {
					return u.id;
				}
				else if(u.id == id) {
					foundUnit = true;
				}
			}
			return firstUnit;
		}
		
		public function countUnits(state:String, player:int):int {
			var count:int = 0;
			for each(var unit:UnitElement in units) {
				if((state==null || unit.state==state) && unit.player==player) {
					count++;
				}
			}
			return count;
		}
		
		override protected function RetrieveElements(x:int, y:int, elements:Vector.<MapElement>):void {
			var cell:Object = maps[x+"_"+y];
			for(var id:String in cell) {
				elements.push(cell[id]);
			}
		}
		
		public function process():void {
			for each(var unit:UnitElement in units) {
				unit.process();
			}
		}
	}
	
}
