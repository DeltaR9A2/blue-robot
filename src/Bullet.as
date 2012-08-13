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
	
	public class Bullet extends BaseWeapon implements IWeapon
	{
		
		public var baseSpeed:Number = 256;
		
		public var travelAngle:Number = 0.0;
		public var realSpeed:Number = 256;

		public var angleVariance:Number = 0.0;
		public var speedVariance:Number = 0.0;
		
		public var seekRate:Number = 0.0;

		public var lifeSpan:Number = 10.0;
		public var despawn:Number = NaN;

		public function startAttacking():void{ return; }
		public function stopAttacking():void{ return; }
		public function isAttacking():Boolean{ return true; }
		public function readyToAttack():Boolean{ return false; }
		
		public function getDamage():Number
		{
			return 1;
		}
		
		public function setPath(nStart:IRect, nToward:IRect):void
		{
			revive();
			flicker(0);
			despawn = lifeSpan;
			solid = true;
			moves = true;

			source = nStart;
			target = nToward;

			moveTo(source);
			
			travelAngle = angleTo(target);
			if(angleVariance > 0.0){
				travelAngle += (Rand.angleMod()*angleVariance);
			}

			realSpeed = baseSpeed;
			if(speedVariance > 0.0){
				realSpeed += Rand.integer(-speedVariance, +speedVariance);
			}
		}
		
		override public function update():void
		{
			super.update();

			if(!onScreen()){
				kill();
			}
			
			if(despawn > 0){
				despawn -= FlxG.elapsed;
			}else{
				kill();
			}

			if(flickering){
				return;
			}
			
			if(seekRate > 0){
				var angleDiff:Number = angleTo(target) - travelAngle;
				if(angleDiff < (-(Math.PI/2))){ angleDiff += (2*Math.PI); }
				if(angleDiff > ( (Math.PI/2))){ angleDiff -= (2*Math.PI); }
				
				if(Math.abs(angleDiff) < (Math.PI / 3)){
				
					var adjustedSeekStrength:Number = seekRate * FlxG.elapsed;
					travelAngle = (travelAngle * (1.0-adjustedSeekStrength)) + ((travelAngle+angleDiff) * adjustedSeekStrength);
					if(travelAngle < (-Math.PI)){ travelAngle += (2*Math.PI); }
					if(travelAngle > ( Math.PI)){ travelAngle -= (2*Math.PI); }
				}
			}
			
			moveAtAngle(travelAngle, realSpeed * FlxG.elapsed);
		}
		
		public function onContact(x:FlxObject):Boolean
		{
			if(x == owner){
				return false;
			}else{
				x.hurt(getDamage());
				solid = false;

				despawn = 0.5;
				flicker(0.55);

				return true;
			}
		}
			
		
		public static function bulletHit(bullet:Bullet, other:FlxObject):void
		{
			bullet.onContact(other);
		}
		
		public static function addBullet(type:Class, source:IRect, target:IRect, owner:FlxBasic):void
		{
			var bullet:Bullet = Main.level.bullets.recycle(type) as Bullet;
			bullet.owner = owner;
			bullet.setPath(source, target);
		}
	}
}
