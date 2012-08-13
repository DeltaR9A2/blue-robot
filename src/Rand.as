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
	
	public class Rand
	{
		
		public function Rand()
		{
			
		}
		
		public static function integer(min:int, max:int):int
		{
			return min + int(FlxG.random() * ((max - min) + 1));
		}
		
		public static function dice(number:int, sides:int):int
		{
			var total:int = number;
			
			for(var i:int = 0; i < number; i++){
				total += int(FlxG.random() * sides);
			}
			
			return total;
		}
		
		public static function angle():Number
		{
			return (2*Math.PI) * FlxG.random();
		}
		
		public static function angleMod():Number
		{
			return Rand.angle() - Math.PI
		}
	}

}
