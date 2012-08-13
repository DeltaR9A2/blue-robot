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
	
	public class Door extends Active
	{
		[Embed(source="../data/images/door.png", mimeType="image/png")] private static var SpriteSheet:Class;
		
		public static var byName:Object = null;
		
		public var broken:Boolean = false;
		
		public var locked:Boolean = false;
		public var accessName:String = "";
		
		public var doorName:String = "";
		public var doorTarget:String = "";
		
		public var instructionTimer:Number = 0.0;
		
		public function Door(element:XML)
		{
			loadGraphic(SpriteSheet, true, false, 64, 64);
			addAnimation("locked", [0,1], 5, true);
			addAnimation("unlocked", [2,3], 5, true);
			addAnimation("broken", [4,5], 5, true);
			
			addAnimation("locked_selected", [8, 9], 5, true);
			addAnimation("unlocked_selected", [10, 11], 5, true);
			addAnimation("broken_selected", [12, 13], 5, true);

			x = element.@x;
			y = element.@y;
			
			doorName = element.@name;
			doorTarget = element.@target;
			
			accessName = element.@access;
			
			if(doorTarget == ""){
				broken = true;
			}
			
			if(accessName != ""){
				locked = true;
			}
			
			Door.byName[doorName] = this;
		}
		
		override public function activate():void
		{
			if(doorTarget == ""){
				Main.statusMessage("This door is malfunctioning and will not open.");
			}else if(locked){
				if(Main.player.accessKeys.indexOf(accessName) != -1){
					this.locked = false;
					Main.statusMessage("The door is now unlocked.");
				}else{
					Main.statusMessage("This door is locked.");
				}
			}else{
				Main.player.moveToDoor(this.doorTarget);
			}
		}
		
		override public function update():void
		{
			super.update();
			
			if(broken){
				play("broken");
			}else if(Main.player.targetActive == this){
				instructionTimer -= FlxG.elapsed;
				if(instructionTimer <= 0){
					Main.contextMessage("[E] Use Door");
					instructionTimer = 0.5;
				}
				
				if(locked){
					play("locked_selected");
				}else{
					play("unlocked_selected");
				}
			}else{
				instructionTimer = 0.0;
				
				if(locked){
					play("locked");
				}else{
					play("unlocked");
				}
			}
		}
	}
}
