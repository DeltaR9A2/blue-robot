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
	
	public class Monster extends FlxSprite
	{
		public var touchDamage:Number = 0;
		
		public var damageThreshold:Number = 0;
		
		public var ambientDelay:Number = 0.0;
		public var ambientSound:Class = null;
		
		public var pathExpire:Number = 0;
		public var patrolSpeed:Number = 0;
		public var patrolPath:FlxPath = new FlxPath;
		
		public function Monster(element:XML)
		{
			super();

			this.x = element.@x;
			this.y = element.@y;
			
			patrolPath.add(element.@x, element.@y);
			
			for each (var node:XML in (element.node)){
				patrolPath.add(node.@x, node.@y);
			}
			
			ambientDelay = 3.0;
			
			this.health = 1;
		}
		
		public function onDamage():void
		{
			return;
		}
		
		public function onDeath():void
		{
			return;
		}
		
		public function animSelect():void
		{
			return;
		}
		
		public function updateLogic():void
		{
			return;
		}
		
		public function updatePhysics():void
		{
			return;
		}
		
		override public function update():void
		{
			if(this.health <= 0){
				onDeath();
				this.kill();
				return;
			}
			
			var rangeToPlayer:Number = this.rangeTo(Main.player);
			
			if(rangeToPlayer > 512){ return; }

			if(ambientSound != null){
				if(ambientDelay <= 0 && rangeToPlayer < 128){
					FlxG.play(ambientSound, 1.0);
					ambientDelay = 1.0 + (FlxG.random() * 3.0);
				}else{
					ambientDelay = Math.max(0, ambientDelay - FlxG.elapsed);
				}
			}
			
			updateLogic();
			updatePhysics();
			animSelect();
		}
		
		
		override public function hurt(damage:Number):void
		{
			damage -= damageThreshold;
			if(damage > 0){
				health -= int(damage);
				FlyText.flyText(this, damage.toString(), 0xFF3333);
				onDamage();
			}else{
				FlyText.flyText(this, "0", 0xFFFF33);
			}
		}
		
		public static function touchOfDeath(player:Player, enemy:Monster):void
		{
			player.hurt(enemy.touchDamage);
		}
	}
}
