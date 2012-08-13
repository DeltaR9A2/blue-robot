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
	
	public class PlayerGraphics extends PlayerPhysics
	{
		[Embed(source="../data/images/playerSprite.png", mimeType="image/png") ] private static const SpriteSheet:Class;
		[Embed(source="../data/sounds/jump.mp3",         mimeType="audio/mpeg")] private static const JumpSound:Class;
		[Embed(source="../data/sounds/player_hurt.mp3",  mimeType="audio/mpeg")] private static const HurtSound:Class;
		[Embed(source="../data/sounds/player_death.mp3", mimeType="audio/mpeg")] private static const DeathSound:Class;
		
		public function PlayerGraphics()
		{
			super();

			loadGraphic(SpriteSheet, true, true, 38, 38);
			addAnimation("standing",     [ 0],                 5, false );
			addAnimation("running",      [ 1, 2, 3, 4, 5, 6], 10, false );
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
			
		}
		
		public function animSelect():void
		{
			if(attackDirection){
				facing = attackDirection;
			}else{
				facing = runDirection;
			}
			
			if(isTouching(FLOOR)){
				if(running && attackDirection){
					if(this.runDirection == this.attackDirection){
						play("run_fire");
					}else{
						play("run_fire_back");
					}
				}else if(this.running){
					play("running");
				}else if(Math.abs(this.velocity.x) > 1){
					attackDirection ? play("skid_fire") : play("skidding");
				}else{
					attackDirection ? play("stand_fire") : play("standing");
				}
			}else{
				if(velocity.y < -(jumpSpeed/6)){
					attackDirection ? play("rise_fire") : play("rising");
				}else if(velocity.y > (fallSpeed/6)){
					attackDirection ? play("fall_fire") : play("falling");
				}else{
					attackDirection ? play("crest_fire") : play("cresting");
				}
			}
		}
	}
}
