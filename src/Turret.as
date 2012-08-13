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
	
	public class Turret extends Monster
	{
		[Embed(source="../data/images/enemyTurret.png", mimeType="image/png")] private static var Sprite:Class;
		[Embed(source="../data/sounds/enemy_hurt.mp3", mimeType="audio/mpeg")] private static var HurtSound:Class;

		public var cannon:Cannon;
		
		public var wakeDelay:Number = 1.0;
		
		public function Turret(element:XML)
		{
			super(element);
			
			this.loadRotatedGraphic(Sprite, 32, -1, true);
			
			health = 50;
			damageThreshold = 6;
			
			width = 16;
			height = 16;
			
			offset.x = 8;
			offset.y = 8;
			
			this.x -= this.width>>1;
			this.y -= this.height>>1;
			
			cannon = new Cannon(this);
			cannon.source = cannon;
			cannon.target = Main.player;
			cannon.firing = false;
		}

		override public function onDamage():void
		{
			FlxG.play(HurtSound);
		}
		
		override public function onDeath():void
		{
			Poof.poof(this.getMidpoint());
			Coin.coinBurst( Rand.dice(2,6), Coin.COPPER, this.getMidpoint());
			Coin.coinBurst( Rand.dice(2,4), Coin.SILVER, this.getMidpoint());
		}

		override public function animSelect():void
		{
		}
		
		override public function updateLogic():void
		{
			var angle:Number = angleTo(Main.player);
			cannon.midX = midX + (Math.cos(angle) * 4);
			cannon.midY = midY + (Math.sin(angle) * 4);
			this.angle = angle * Main.radToDeg;
			
			if(onScreen()){
				if(wakeDelay <= 0.0){
					cannon.firing = true;
				}else{
					wakeDelay -= FlxG.elapsed;
				}
			}else{
				cannon.firing = false;
				wakeDelay = 0.25;
			}
			
			cannon.update();
		}
	}
}
