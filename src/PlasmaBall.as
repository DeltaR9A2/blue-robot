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
	public class PlasmaBall extends Bullet
	{
		[Embed(source="../data/images/bulletPlasmaBall.png", mimeType="image/png")] public static const SpriteSheet:Class;
		
		public function PlasmaBall()
		{
			super();
			
			loadGraphic(SpriteSheet, true, false, 8, 8);
			addAnimation("pulse", [0,1], 5, true);
			play("pulse")
			
			this.h = 2;
			this.w = 2;
			this.offset.x = 3;
			this.offset.y = 3;
			
			baseSpeed = 128;
		}
		
		override public function getDamage():Number
		{
			return 1;
		}
	}
}
