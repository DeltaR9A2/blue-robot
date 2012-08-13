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
	
	public class Heart extends Pickup
	{
		[Embed(source="../data/images/pickupHearts.png", mimeType="image/png")] private static var SpriteSheet:Class;
		[Embed(source="../data/sounds/default_pickup.mp3")] private static var CollectSound:Class;
		
		public var accessName:String = "";
		
		public function Heart(element:XML)
		{
			loadGraphic(SpriteSheet, true, false);
			addAnimation("pulse", [0, 1], 5, true);
			play("pulse");
			
			reset(element.@x, element.@y);
		}
		
		override public function collectible():Boolean
		{
			return (Main.player.curHealth < Main.player.maxHealth);
		}
		
		override public function onCollect():void
		{
			Main.player.curHealth = Math.min(Main.player.curHealth + 1, Main.player.maxHealth);
			FlxG.play(CollectSound);
		}
	}
}
