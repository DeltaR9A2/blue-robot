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
	
	public class Player extends FlxSprite
	{
		[Embed(source="../data/images/playerSprite.png", mimeType="image/png") ] private static const SpriteSheet:Class;
		[Embed(source="../data/sounds/jump.mp3",         mimeType="audio/mpeg")] private static const JumpSound:Class;
		[Embed(source="../data/sounds/player_hurt.mp3",  mimeType="audio/mpeg")] private static const HurtSound:Class;
		[Embed(source="../data/sounds/player_death.mp3", mimeType="audio/mpeg")] private static const DeathSound:Class;
		
		public static const RIFLE:uint = 0;
		public static const SHOTGUN:uint = 1;
		public static const BLASTER:uint = 2;
		
		public var running:Boolean = false;
		public var runDirection:uint = RIGHT;
		public var runSpeed:Number = 128;
		public var runForce:Number = 1000;
		public var runDrag:Number = 500;
		
		public var attackDirection:uint = RIGHT;
		
		public var jumpSpeed:Number = 200;
		public var jumpForce:Number = 750;
		public var fallSpeed:Number = 200;
		public var fallForce:Number = 750;
		public var holdingJump:Boolean = false;

		public var maxHangTime:Number = 0.32;
		public var curHangTime:Number = 0.0;
		
		public var dropThrough:Boolean = false;
		
		public var weapon:IWeapon = null;
		public var weaponIndex:uint = 0;
		public var weaponSource:IRect = null;
		
		public var accessKeys:Array = [];
		public var money:Number = 0;
		public var coinCollectRange:Number = 32;
		
		public var maxHealth:int = 10;
		public var curHealth:int = 10;

		public var targetActive:Active = null;

		public var gameOverTimer:Number = NaN;
		
		public var arsenal:Array = null;
		
		public var save:SaveGame = null;
		
		public function Player()
		{
			super();

			loadGraphic(SpriteSheet, true, true, 38, 38);
			addAnimation("standing",     [ 0],                 5, false );
			addAnimation("running",      [ 1, 2, 3, 4, 5, 6], 10, false );
			addAnimation("run_back",     [ 6, 5, 4, 3, 2, 1], 10, false );
			addAnimation("skidding",     [ 7],                 5, false );
			addAnimation("stand_fire",   [ 8],                 5, false );
			addAnimation("run_fire",     [ 9,10,11,12,13,14], 10, false );
			addAnimation("run_fire_back",[14,13,12,11,10, 9], 10, false );
			addAnimation("skid_fire",    [15],                 5, false );
			addAnimation("rising",       [16],                 5, false );
			addAnimation("cresting",     [17],                 5, false );
			addAnimation("falling",      [18],                 5, false );
			addAnimation("rise_fire",    [19],                 5, false );
			addAnimation("crest_fire",   [20],                 5, false );
			addAnimation("fall_fire",    [21],                 5, false );
			
			width = 16;
			height = 30;

			offset.x = 11;
			offset.y = 7;
			
			maxVelocity.x = runSpeed;
			drag.x = runDrag;
			
			weaponSource = new Rect;
			
			arsenal = new Array;
			
			arsenal[RIFLE] = new SMG(this);
			arsenal[SHOTGUN] = new Shotgun(this);
			arsenal[BLASTER] = new Blaster(this);
			
			for each(var w:IWeapon in arsenal){
				w.source = weaponSource;
				w.target = FlxG.mouse;
			}
			
			weaponIndex = RIFLE;
			weapon = arsenal[weaponIndex];
			
			save = Main.saveSlot1;
			trace(save.saveBound);
			if(save.data.money == null){
				save.data.money = 0;
			}else{
				money = save.data.money;
			}
		}

		public function jump():void
		{
			if(this.isTouching(FLOOR)){
				this.holdingJump = true;
				this.acceleration.y = -jumpForce;
				this.maxVelocity.y = jumpSpeed;
				this.velocity.y = -jumpSpeed;
				FlxG.play(JumpSound);
			}
		}
		
		public function jumpStop():void
		{
			this.holdingJump = false;
			if(this.velocity.y < 0){ this.velocity.y *= 0.5; }
		}

		
		public function updateControls():void
		{
			if(!isNaN(gameOverTimer)){ return; }
			
			if(FlxG.keys.S){
				dropThrough = true;
			}else{
				dropThrough = false;
			}
			
			if(targetActive != null){
				if(FlxG.keys.justPressed("E")){
					targetActive.activate();
				}
				targetActive = null;
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
				weapon.startAttacking();
			}else if(FlxG.mouse.justReleased()){
				weapon.stopAttacking();
			}

			if(weapon.isAttacking()){
				if(FlxG.mouse.x < this.x+(this.width/2)){
					attackDirection = LEFT;
				}else{
					attackDirection = RIGHT;
				}
			}else{
				attackDirection = NONE;
			}
			
			if(FlxG.keys.justPressed("ONE")){
				switchWeapon(RIFLE);
			}else if(FlxG.keys.justPressed("TWO")){
				switchWeapon(SHOTGUN);
			}else if(FlxG.keys.justPressed("THREE")){
				switchWeapon(BLASTER);
			}
		}
		
		public function switchWeapon(index:uint):void
		{
			weapon.stopAttacking();
			weaponIndex = index;
			weapon = arsenal[weaponIndex];
		}
		
		public function animSelect():void
		{
			if(isTouching(FLOOR)){
				if(running && weapon.isAttacking()){
					if(this.runDirection == this.attackDirection){
						play("run_fire");
					}else{
						play("run_fire_back");
					}
				}else if(this.running){
					play("running");
				}else if(Math.abs(this.velocity.x) > 1){
					weapon.isAttacking() ? play("skid_fire") : play("skidding");
				}else{
					weapon.isAttacking() ? play("stand_fire") : play("standing");
				}
			}else{
				if(velocity.y < -(jumpSpeed/6)){
					weapon.isAttacking() ? play("rise_fire") : play("rising");
				}else if(velocity.y > (fallSpeed/6)){
					weapon.isAttacking() ? play("fall_fire") : play("falling");
				}else{
					weapon.isAttacking() ? play("crest_fire") : play("cresting");
				}
			}
		}
		
		public function updatePhysics():void
		{
			if(running){
				if(runDirection == RIGHT){
					acceleration.x = runForce;
				}else if(runDirection == LEFT){
					acceleration.x = -runForce;
				}
			}else{
				acceleration.x = 0;
			}
			
			if(attackDirection){
				facing = attackDirection;
			}else{
				facing = runDirection;
			}
			
			if(curHangTime > maxHangTime || justTouched(CEILING)){
				jumpStop();
			}
			
			if(holdingJump && curHangTime < maxHangTime){
				acceleration.y = -jumpForce;
				maxVelocity.y = jumpSpeed;
				curHangTime += FlxG.elapsed;
			}else{
				acceleration.y = fallForce;
				maxVelocity.y = fallSpeed;
				curHangTime = 0.0;
			}
		}

		override public function update():void
		{
			super.update();
			
			weaponSource.x = (attackDirection == RIGHT)?(rEdge):(lEdge);
			weaponSource.y = midY - 4;
			
			if(curHealth <= 0 && isNaN(gameOverTimer)){
				FlxG.play(DeathSound);
				Poof.poof(this);
				gameOverTimer = 5.0;
				weapon.stopAttacking();
				visible = false;
				moves = false;
				solid = false;
			}
			
			if(!isNaN(gameOverTimer)){
				this.gameOverTimer -= FlxG.elapsed;
				
				if(this.gameOverTimer <= 0){
					Main.player.moveToDoor("gameover");
				}
			}
			
			updateControls();
			updatePhysics();
			animSelect();
			
			for each(var w:IWeapon in arsenal){ w.update(); }
			
			save.data.money = money;
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
		
		public static function bridgeTest(player:Player, bridge:FlxObject):Boolean
		{
			return !player.dropThrough;
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
