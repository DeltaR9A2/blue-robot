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
	
	public class PlayerPhysics extends FlxSprite
	{
		public var running:Boolean = false;
		public var runDirection:uint = RIGHT;
		public var runSpeed:Number = 128;
		public var runForce:Number = 1000;
		public var runDrag:Number = 500;
		
		public var attackDirection:uint = NONE;

		public var jumpSpeed:Number = 200;
		public var jumpForce:Number = 750;
		public var fallSpeed:Number = 200;
		public var fallForce:Number = 750;
		public var holdingJump:Boolean = false;

		public var maxHangTime:Number = 0.32;
		public var curHangTime:Number = 0.0;
		
		public var dropThrough:Boolean = false;
		
		public function PlayerPhysics()
		{
			super();

			maxVelocity.x = runSpeed;
			drag.x = runDrag;
		}

		public function jump():void
		{
			if(this.isTouching(FLOOR)){
				this.holdingJump = true;
				this.acceleration.y = -jumpForce;
				this.maxVelocity.y = jumpSpeed;
				this.velocity.y = -jumpSpeed;
			}
		}
		
		public function jumpStop():void
		{
			this.holdingJump = false;
			if(this.velocity.y < 0){ this.velocity.y *= 0.5; }
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

		public static function bridgeTest(player:Player, bridge:FlxObject):Boolean
		{
			return !player.dropThrough;
		}
	}
}
