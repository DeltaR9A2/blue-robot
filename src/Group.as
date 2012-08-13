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
	
	public class Group extends FlxGroup
	{
		
		public static var padding:int = 2;
		
		public var loc:FlxObject = null;
		
		public function Group(w:Number, h:Number)
		{
			super();
			
			loc = new FlxObject;
			loc.width = w;
			loc.height = h;
			add(loc);
		}

		public function syncX():void{}
		public function syncY():void{}
		public function syncW():void{}
		public function syncH():void{}
		
		override public function get x():Number{ return loc.x; }
		override public function get y():Number{ return loc.y; }
		override public function set x(n:Number):void{ loc.x = n; syncX(); }
		override public function set y(n:Number):void{ loc.y = n; syncY(); }

		override public function get w():Number{ return loc.w; }
		override public function get h():Number{ return loc.h; }
		override public function set w(n:Number):void{ loc.w = n; syncW(); }
		override public function set h(n:Number):void{ loc.h = n; syncH(); }
	}
}
