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
	public class HUDElement extends Group
	{
		public var bg:FlxSprite = null;
		
		public function HUDElement(w:Number, h:Number)
		{
			super(w, h);
			loc.scrollFactor.x = 0;
			loc.scrollFactor.y = 0;
			
			bg = new FlxSprite;
			bg.scrollFactor.x = 0;
			bg.scrollFactor.y = 0;
			bg.makeGraphic(loc.width, loc.height, 0x55000000);
			bg.x = loc.x;
			bg.y = loc.y;
			add(bg);
		}
		
		override public function syncX():void{ bg.x = loc.x; }
		override public function syncY():void{ bg.y = loc.y; }
	}
}
