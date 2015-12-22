package  {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class UnitElement extends MapElement {

		public var id:String;
		public var state:String;
		public var frameOrigin:int;
		public var player:int;
		public var cellID:String;
		public var transformation:String;
		public var goal:Point;
		public var attackingPlayer:int = 0;
		public var foe:String = null;
		public var life:int;
		
		public function get selected():Boolean {
			var setting:PlayerSetting = PlayerSetting.GetSetting(player);
			if(setting) {
				return setting.selection == id;
			}
			return false;
		}
		
		public function performAttack(attackCommand:String):void {
			var setting:PlayerSetting = PlayerSetting.GetSetting(player);
			if(attackCommand.indexOf("ATTACK_")>=0) {
				var playerToAttack:int = attackCommand.split("ATTACK_")[1];
				attackingPlayer = playerToAttack;
			}
			setting.selection = ObjectMap.Instance.nextUnit(this.id, this.player);
		}
		
		public function canPerformAction(action:String):Boolean {
			if(Config.COST[action]) {
				var setting:PlayerSetting = PlayerSetting.GetSetting(player);
				if(setting.carrots < Config.COST[action]) {
					return false;
				}
			}
			return true;
		}
		
		public function performAction(action:String):void {
			var setting:PlayerSetting = PlayerSetting.GetSetting(player);
			if(Config.COST[action]) {
				setting.addCarrot(-Config.COST[action]);
			}
			
			switch(action) {
				case "HATCH":
					transformation = "E-S";
					state = "Slime";
					frameOrigin = Game.Instance.frame;
					life = Config.LIFE[state];
					break;
				case "GROW_AS_GATHERER":
					transformation = "S-G";
					state = "Gatherer";
					frameOrigin = Game.Instance.frame;
					life = Config.LIFE[state];
					break;
				case "GROW_AS_QUEEN":
					transformation = "S-Q";
					state = "Queen";
					frameOrigin = Game.Instance.frame;
					life = Config.LIFE[state];
					break;
				case "GROW_AS_WARRIOR":
					transformation = "S-W";
					state = "Warrior";
					frameOrigin = Game.Instance.frame;
					life = Config.LIFE[state];
					break;
				case "GROW_AS_ARCHER":
					transformation = "S-A";
					state = "Archer";
					frameOrigin = Game.Instance.frame;
					life = Config.LIFE[state];
					break;
				case "GROW_AS_LEADER":
					transformation = "W-L";
					state = "Leader";
					frameOrigin = Game.Instance.frame;
					life = Config.LIFE[state];
					break;
				case "GROW_AS_FLYER":
					transformation = "S-F";
					state = "Flyer";
					frameOrigin = Game.Instance.frame;
					life = Config.LIFE[state];
					break;
				case "ATTACK":
					PlayerAttacker.Get(player).show(state);
					break;
				case "LAY":
					ObjectMap.Instance.AddUnit("Egg",player,x,y);
					break;
			}
		}
		
		private function attackFoe(foeUnit:UnitElement):void {
			foeUnit.life -= Math.ceil(Config.ATTACK[state] / Config.DEFENSE[foeUnit.state]);
			if(foeUnit.life<=0) {
				foeUnit.state = "KO";
				foeUnit.transformation = "KO";
				foeUnit.frameOrigin = Game.Instance.frame;
			}
		}
		
		public function get MAXLIFE():int {
			return Config.LIFE[state];
		}
		
		private function Move():void {
			switch(state) {
				case "Queen":
				case "Gatherer":
				case "Slime":
				case "Archer":
				case "Warrior":
				case "Leader":
				case "Flyer":
					var foeUnit:UnitElement = ObjectMap.Instance.GetUnit(foe);
					if(!goal && !foeUnit) {
						var sceneLayer:SceneLayer = SceneLayer.GetSceneLayer(attackingPlayer ? attackingPlayer : player);
						var dim:Rectangle = new Rectangle(
							sceneLayer.position.x,
							sceneLayer.position.y,
							sceneLayer.zoom * 1024/4,
							sceneLayer.zoom * 768/2
						);
						goal = new Point(dim.x + dim.width*Math.random(), dim.y + dim.height*Math.random());
					} else {
						if(Slimo.frameStructure) {
							var frames:Array = Slimo.frameStructure[state];
							var frame:int = frames[Math.floor((Game.Instance.frame - frameOrigin) / Config.FRAME_LIMIT[state]) % frames.length];
							if(Config.JUMP_FRAME.indexOf(frame)>=0) {
								var dest:Point = goal;
								var range:Number = .002;
								if(foeUnit) {
									dest = new Point(foeUnit.x,foeUnit.y);
									switch(state) {
										case "Warrior":
										case "Leader":
											range = .3;
											break;
										case "Archer":
											range = 4;
											break;
										case "Flyer":
											range = 1.5;
											break;
									}
								}
								var dist:Number = Point.distance(dest,new Point(x,y));
								if(dist<range) {
									if(foeUnit) {
										//	Attack
										attackFoe(foeUnit);
										foe = null;
									}
									goal = null;
								} else {
									var speed:Number = Math.min(dist,state=="Leader"?.2:.1);
									var xDest:Number = x + (dest.x - x)/dist*speed;
									var yDest:Number = y + (dest.y - y)/dist*speed;
									ObjectMap.Instance.SetUnit(this,xDest,yDest);
								}
							}
						}
					}
					break;
			}
		}
		
		public function MoreAction():void {
			var units:Vector.<MapElement>;
			var unit:UnitElement;
			var sceneLayer:SceneLayer;
			var dim:Rectangle;
			
			switch(state) {
				case "Gatherer":
					if((Game.Instance.frame - frameOrigin) % 100==0) {
						var carrot:UnitElement = ObjectMap.Instance.AddUnit("Carrot",player,x,y);
						carrot.transformation = "Carrot";
					}
					break;
				case "Queen":
					if((Game.Instance.frame - frameOrigin) % 500==0) {
						sceneLayer = SceneLayer.GetSceneLayer(attackingPlayer ? attackingPlayer : player);
						dim = new Rectangle(
							sceneLayer.position.x,
							sceneLayer.position.y,
							sceneLayer.zoom * 1024/4,
							sceneLayer.zoom * 768/2
						);
						units = ObjectMap.Instance.GetElements(dim);
						var minDist:Number = Number.MAX_VALUE;
						var u:UnitElement = null;
						for each(unit in units) {
							if(unit != this && unit.player == player && unit.life < unit.MAXLIFE && distanceTo(unit)<minDist) {
								minDist = distanceTo(unit);
								u = unit;
							}
						}
						if(u) {
							u.life = Math.min(u.MAXLIFE, u.life+5);
							var heart:UnitElement = ObjectMap.Instance.AddUnit("Heart",player,u.x,u.y);
							heart.transformation = "Heart";
						}
					}
					break;
					break;
				case "Warrior":
				case "Archer":
				case "Flyer":
				case "Leader":
					if((Game.Instance.frame - frameOrigin) % 10==0) {
						sceneLayer = SceneLayer.GetSceneLayer(attackingPlayer ? attackingPlayer : player);
						dim = new Rectangle(
							sceneLayer.position.x,
							sceneLayer.position.y,
							sceneLayer.zoom * 1024/4,
							sceneLayer.zoom * 768/2
						);
						units = ObjectMap.Instance.GetElements(dim);
						var foes:Array = [];
						for each(unit in units) {
							if(unit.player != player && unit.life > 0) {
								if(!Config.CANTATTACK[state] || !Config.CANTATTACK[state][unit.state]) {
									foes.push(unit.id);
								}
							}
						}
						if(foes.length) {
							var newFoe:String = foes[Math.floor(Math.random()*foes.length)];
							if(!foe || !ObjectMap.Instance.GetUnit(foe) || 
								distanceTo(ObjectMap.Instance.GetUnit(foe)) > distanceTo(ObjectMap.Instance.GetUnit(newFoe))) {
								foe = newFoe;	
							}
						} else {
							if(this.attackingPlayer!=0) {
								attackingPlayer = 0;
							}
						}
					}
					break;
			}
		}
		
		public function distanceTo(unit:UnitElement):Number {
			return Point.distance(new Point(x,y), new Point(unit.x, unit.y));
		}
		
		public function process():void {
			if(transformation) {
				if(Game.Instance.frame - frameOrigin > 50) {
					transformation = null;
					switch(state) {
						case "Carrot":
							var setting:PlayerSetting = PlayerSetting.GetSetting(player);
							PlayerSetting.GetSetting(player).addCarrot(setting.ai<=1 ? 1 : setting.ai==2?2:5);
							ObjectMap.Instance.RemoveUnit(this);
							break;
						case "KO":
							ObjectMap.Instance.RemoveUnit(this);
							break;
						case "Heart":
							ObjectMap.Instance.RemoveUnit(this);
							break;
					}
				}
			} else {
				Move();
				MoreAction();
			}
		}
		
		public function get selectable():Boolean {
			return Config.SELECTABLE.indexOf(state)>=0 && !attackingPlayer;
		}
	}
	
}
