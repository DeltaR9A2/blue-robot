  /*===================*\
 /* License Information *\
/*====================================================================*\
|                                                                      |
| This file is part of Blue Robot, a flash game by John Colburn.       |
|                                                                      |
| Blue Robot is free software: you can redistribute it and/or modify   |
| it under the terms of the GNU General Public License as published by |
| the Free Software Foundation, either version 3 of the License, or    |
| (at your option) any later version.                                  |
|                                                                      |
| Blue Robot is distributed in the hope that it will be useful,        |
| but WITHOUT ANY WARRANTY; without even the implied warranty of       |
| MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        |
| GNU General Public License for more details.                         |
|                                                                      |
| You should have received a copy of the GNU General Public License    |
| along with Blue Robot. If not, see <http://www.gnu.org/licenses/>.   |
|                                                                      |
\*====================================================================*/

package
{
	import org.flixel.*;
	
	public class Player extends PlayerGraphics
	{
		[Embed(source="../data/images/playerSprite.png", mimeType="image/png") ] private static const SpriteSheet:Class;
		[Embed(source="../data/sounds/jump.mp3",         mimeType="audio/mpeg")] private static const JumpSound:Class;
		[Embed(source="../data/sounds/player_hurt.mp3",  mimeType="audio/mpeg")] private static const HurtSound:Class;
		[Embed(source="../data/sounds/player_death.mp3", mimeType="audio/mpeg")] private static const DeathSound:Class;
		
		public static const RIFLE:uint = 0;
		public static const SHOTGUN:uint = 1;
		public static const BLASTER:uint = 2;
		
		public var weapon:IWeapon = null;
		public var weaponSource:IRect = null;
		
		public var maxHealth:int = 10;
		public var curHealth:int = 10;

		public var save:PlayerSave = null;
		
		public function Player()
		{
			super();
			
			weaponSource = new Rect;
		}

		public function updateControls():void
		{
			if(curHealth <= 0){ return; }
			
			if(FlxG.keys.S){
				dropThrough = true;
			}else{
				dropThrough = false;
			}
			
			if(FlxG.keys.justPressed("E")){

			}

			if(FlxG.keys.justPressed("W")){
				jump();
			}
			
			if(FlxG.keys.justReleased("W")){
				jumpStop();
			}
			
			if(FlxG.keys.A && !FlxG.keys.D){
				running = true;
				runDirection = LEFT;
			}else if(FlxG.keys.D && !FlxG.keys.A){
				running = true;
				runDirection = RIGHT;
			}else{
				running = false;
			}
			
			if(FlxG.mouse.justPressed()){
				//weapon.startAttacking();
			}else if(FlxG.mouse.justReleased()){
				//weapon.stopAttacking();
			}

			if(weapon != null && weapon.isAttacking()){
				if(FlxG.mouse.x < this.x+(this.width/2)){
					attackDirection = LEFT;
				}else{
					attackDirection = RIGHT;
				}
			}else{
				attackDirection = NONE;
			}
		}
		
		override public function update():void
		{
			super.update();
			
			weaponSource.x = (attackDirection == RIGHT)?(rEdge):(lEdge);
			weaponSource.y = midY - 4;
			
			if(curHealth <= 0){
				FlxG.play(DeathSound);
				Poof.poof(this);
				weapon.stopAttacking();
				exists = false;
			}
			
			updateControls();
			updatePhysics();
			animSelect();
		}

		override public function hurt(damage:Number):void
		{
			if(!flickering){
				this.curHealth -= int(1);
				this.flicker(1.5);
				FlxG.flash(0x55FF5500, 0.25);
				FlxG.play(HurtSound);
			}
		}
		
		public function moveToDoor(name:String):void
		{
			var currentLevel:Level = FlxG.state as Level;
			var targetDoor:FlxObject = Door.byName[name];
			var targetLevel:FlxState = Level.byDoorName[name];

			if(targetDoor == null || targetLevel == null){
				throw(new Error("Error moving to target door: " + name));
			}
			
			moveTo(targetDoor);

			FlxG.switchState(targetLevel);
		}
	}
}
