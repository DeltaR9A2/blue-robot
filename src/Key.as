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
	
	public class Key extends Pickup
	{
		[Embed(source="../data/images/pickupKeyCard.png", mimeType="image/png")] private static var SpriteSheet:Class;
		[Embed(source="../data/sounds/default_pickup.mp3")] private static var CollectSound:Class;
		
		public var accessName:String = "";
		
		public function Key(element:XML)
		{
			loadGraphic(SpriteSheet);

			accessName = element.@access;
			
			reset(element.@x, element.@y);
			
			stationary = false;
			acceleration.y = 128;
			elasticity = 0.1;
		}
		
		override public function onCollect():void
		{
			FlxG.play(CollectSound);
		}
	}
}
