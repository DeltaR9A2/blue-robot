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
	
	public class BigBee extends Monster
	{
		[Embed(source="../data/images/enemyBees.png", mimeType="image/png")] private static var SpriteSheet:Class;
		[Embed(source="../data/sounds/enemy_hurt.mp3", mimeType="audio/mpeg")] private static var HurtSound:Class;

		public var keyDrop:String = null;
		public var seekingPlayer:Boolean = false;
		public var flightAcceleration:Number = 64;
		
		public function BigBee(element:XML)
		{
			keyDrop = element.@keyDrop;
			
			super(element);
			
			this.loadGraphic(SpriteSheet, true, true, 32, 32);

			this.addAnimation("fly", [2,3], 30, true);
			this.play("fly");
			
			health = 100;
			damageThreshold = 2;
			
			maxVelocity.x = 128;
			maxVelocity.y = 128;
		}

		override public function onDamage():void
		{
			seekingPlayer = true;
			FlxG.play(HurtSound);
		}
		
		override public function onDeath():void
		{
			Poof.poof(this.getMidpoint());
			Coin.coinBurst( Rand.integer(5,10), Coin.SILVER, this.getMidpoint());
			Coin.coinBurst( Rand.integer(1,2), Coin.GOLD, this.getMidpoint());
			
			if(keyDrop != ""){
				var element:XML = <key x={x} y={y} access={keyDrop} />
				Main.level.loadEntity(element);
			}
		}

		override public function animSelect():void
		{
			if(this.x < Main.player.x){
				this.facing = RIGHT;
			}else{
				this.facing = LEFT;
			}
		}
		
		override public function updateLogic():void
		{
			if(rangeTo(Main.player) < 160){
				seekingPlayer = true;
			}
		}
		
		override public function updatePhysics():void
		{
			if(seekingPlayer){
				var angle:Number = angleTo(Main.player);
				acceleration.x = Math.cos(angle) * flightAcceleration;
				acceleration.y = Math.sin(angle) * flightAcceleration;
			}
		}
	}
}
