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
	
	public class PlasmaCannon extends Firearm
	{
		[Embed(source="../data/sounds/plasma_cannon_fire.mp3", mimeType="audio/mpeg")] private static var ShotSound:Class;

		public function PlasmaCannon(owner:FlxBasic)
		{
			super(owner);
			this.bulletType = PlasmaBall;
			this.rateOfFire = 0.5;
			this.shotSound = ShotSound;
		}
	}
}
