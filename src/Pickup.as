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
	
	public class Pickup extends FlxSprite
	{
		public static const baseSpeed:Number = 64;
		
		public var collecting:Boolean = false;
		public var collectImmunity:Number = 0.5;
		
		public var originalX:Number = 0;
		public var originalY:Number = 0;
		public var stationary:Boolean = true;
		
		
		override public function reset(x:Number, y:Number):void
		{
			super.reset(x,y);

			originalX = midX;
			originalY = midY;
		
			collecting = false;
			collectImmunity = 0.5;
		}
		
		public function collectible():Boolean
		{
			return true;
		}

		public function updateLogic():void
		{
			var range:Number = rangeTo(Main.player);

			if(collectImmunity > 0){
				collectImmunity -= FlxG.elapsed;
				return;
			}
			
			if(!collectible()){
				collecting = false;
				return;
			}
			
			if(range < 4){
				onCollect();
				kill();
			}else if(range < 32){
				collecting = true;
			}else{
				collecting = false;
			}
		}
		
		public function updatePhysics():void
		{
			if(collecting){
				moveToward(Main.player, FlxG.elapsed*((baseSpeed - rangeTo(Main.player))*5));
			}else if(stationary){
				moveToward(new FlxObject(originalX, originalY), FlxG.elapsed*baseSpeed);
			}
		}
		
		override public function update():void
		{
			super.update();
			updateLogic();
			updatePhysics();
		}
		
		public function onCollect():void
		{
			
		}
	}
}
