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
	public class BlasterBolt extends Bullet
	{
		[Embed(source="../data/images/bulletBlasterBolt.png", mimeType="image/png")] public static const Sprite:Class;
		
		public function BlasterBolt()
		{
			super();
			
			loadRotatedGraphic(Sprite, 32, -1, true);
			
			this.h = 6;
			this.w = 6;
			this.offset.x = 5;
			this.offset.y = 5;
			
			baseSpeed = 160;
		}
		
		override public function getDamage():Number
		{
			return Rand.dice(3, 8) + 5;
		}
		
		override public function update():void
		{
			super.update();
			
			angle = travelAngle * Main.radToDeg;
		}
	}
}
