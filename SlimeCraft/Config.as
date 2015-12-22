package  {
	import flash.ui.Keyboard;
	
	public class Config {

		static public const DEBUG:Boolean = false;
		
		static public var AI:Array = [
			null,
			0,
			0,
			0,
			0
		];
		
		static public const START:Array = [
			["Slime",1,10,10],
			["Slime",1,20,20],
			["Slime",1,10,20],
			["Slime",2,50,20],
			["Slime",2,50,25],
			["Slime",2,45,20],
			["Slime",3,20,50],
			["Slime",3,10,45],
			["Slime",3,15,60],
			["Slime",4,60,60],
			["Slime",4,55,55],
			["Slime",4,65,50]
		];

		static public const KEYS:Array = [
			null,
			[[Keyboard.Q,"Q"], [Keyboard.W,"W"]],
			[[Keyboard.O,"O"], [Keyboard.P,"P"]],
			[[Keyboard.Z,"Z"], [Keyboard.X,"X"]],
			[[Keyboard.N,"N"], [Keyboard.M,"M"]],
		];
		
		static public const FRAME_LIMIT:Object = {
			"Egg":4,
			"E-S":5,
			"Slime":1,
			"S-G":5,
			"Gatherer":2,
			"S-Q":5,
			"Queen":2,
			"S-W":5,
			"Warrior":2,
			"S-A":5,
			"Archer":2,
			"W-L":5,
			"Leader":1,
			"S-F":5,
			"Flyer":2,
			"Carrot":2,
			"KO":2,
			"Heart":1
		};
		
		static public const SELECTABLE:Array = [
			"Egg",
			"Slime",
			"Gatherer",
			"Queen",
			"Warrior",
			"Archer",
			"Leader",
			"Flyer"
		];
		
		static public const LIFE:Object = {
			"Egg":500,
			"Slime":100,
			"Gatherer":100,
			"Queen":250,
			"Warrior":200,
			"Archer":150,
			"Leader":250,
			"Flyer":150
		};
		
		static public const ATTACK:Object = {
			"Egg":0,
			"Slime":5,
			"Gatherer":10,
			"Queen":10,
			"Warrior":40,
			"Archer":20,
			"Leader":50,
			"Flyer":30
		};
		
		static public const DEFENSE:Object = {
			"Egg":12,
			"Slime":2,
			"Gatherer":4,
			"Queen":7,
			"Warrior":8,
			"Archer":6,
			"Leader":10,
			"Flyer":5
		};
		
		static public const COST:Object = {
			"HATCH":5,
			"GROW_AS_GATHERER":10,
			"GROW_AS_QUEEN":20,
			"GROW_AS_WARRIOR":25,
			"GROW_AS_ARCHER":20,
			"GROW_AS_LEADER":30,
			"GROW_AS_FLYER":20,
			"LAY":5
		};
		
		static public const CANTATTACK:Object = {
			"Warrior":{"Flyer":1},
			"Leader":{"Flyer":1}
		};
		
		static public const DESC:Object = {
			"HATCH":"Hatch an egg to produce a slime",
			"GROW_AS_GATHERER":"Gatherers increase your carrot production",
			"GROW_AS_QUEEN":"Queens can lay eggs to grow your population.",
			"GROW_AS_WARRIOR":"Warriors have a melee attack",
			"GROW_AS_ARCHER":"Archers have a range attack. Can attack air",
			"GROW_AS_LEADER":"Knights are faster and stronger warriors",
			"GROW_AS_FLYER":"Bats attack from the air",
			"LAY":"Lay an egg. At any time, you can only have 5 eggs per queen"
		};
		
		static public const EGG_SPAWN:int = 100;

		static public const JUMP_FRAME:Object = [
			22,23,24,25,26,27,28,29,30,31,32,
			49,50,51,58,59,60,66,67,68,
			81,83,84,85,86,87,89,90,
			98,99,100,101,102,
			114,115,116,117,118,119,120,121,122,123,124,
			146,147,148,149,150,151,
			175,176,177,178,179,180,181,182,183,184
		];
		
		static public const STARTING_POSITIONS:Array = [
			null,
			[0,0],
			[40,0],
			[0,40],
			[40,40]
		];
		
		
		static public const UNCOLORED:Object = {
			"Carrot":true,
			"Heart":true
		};
	}
	
}
