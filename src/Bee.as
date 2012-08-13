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
	
	public class Bee extends Monster
	{
		[Embed(source="../data/images/enemyBees.png", mimeType="image/png")] private static var SpriteSheet:Class;
		[Embed(source="../data/sounds/enemy_hurt.mp3", mimeType="audio/mpeg")] private static var HurtSound:Class;

		public function Bee(element:XML)
		{
			super(element);
			
			this.loadGraphic(SpriteSheet, true, true, 32, 32);

			this.addAnimation("fly", [0,1], 30, true);
			this.play("fly");
			
			this.width = 16;
			this.height = 16;
			this.offset.x = 8;
			this.offset.y = 8;
			
			health = 30;
			patrolSpeed = 75;
			
			this.followPath(patrolPath, patrolSpeed, PATH_LOOP_FORWARD, false);
		}

		override public function onDamage():void
		{
			FlxG.play(HurtSound);
		}
		
		override public function onDeath():void
		{
			Poof.poof(this.getMidpoint());
			Coin.coinBurst( Rand.integer(2,5), Coin.COPPER, this.getMidpoint());
			Coin.coinBurst( Rand.integer(0,2), Coin.SILVER, this.getMidpoint());
		}

		override public function animSelect():void
		{
			if(this.x < Main.player.x){
				this.facing = RIGHT;
			}else{
				this.facing = LEFT;
			}
		}
	}
}
