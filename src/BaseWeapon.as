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
	
	public class BaseWeapon extends FlxSprite
	{
		private var _owner:FlxBasic = null;
		public function get owner():FlxBasic{ return _owner; }
		public function set owner(x:FlxBasic):void{ _owner = x; }
		
		private var _source:IRect = null;
		public function get source():IRect{ return _source; }
		public function set source(x:IRect):void{ _source = x; }
		
		private var _target:IRect = null;
		public function get target():IRect{ return _target; }
		public function set target(x:IRect):void{ _target = x; }
	}
}
