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
	public class Rect implements IRect
	{
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _w:Number = 0;
		private var _h:Number = 0;
		
		public function get x():Number{ return _x; }
		public function get y():Number{ return _y; }
		public function set x(n:Number):void{ _x = n; }
		public function set y(n:Number):void{ _y = n; }
		
		public function get w():Number{ return _w; }
		public function get h():Number{ return _h; }
		public function set w(n:Number):void{ _w = n; }
		public function set h(n:Number):void{ _h = n; }
		
		public function get midX():Number{ return x + (w>>1); }
		public function get midY():Number{ return y + (h>>1); }
		public function set midX(n:Number):void{ x = n - (w>>1); }
		public function set midY(n:Number):void{ y = n - (h>>1); }
		
		public function get lEdge():Number { return x; }
		public function get rEdge():Number { return x + w; }
		public function set lEdge(n:Number):void { x = n; }
		public function set rEdge(n:Number):void { x = n - w; }

		public function get tEdge():Number { return y; }
		public function get bEdge():Number { return y + h; }
		public function set tEdge(n:Number):void { y = n; }
		public function set bEdge(n:Number):void { y = n - h; }
		
		public function rangeTo(other:IRect):Number
		{
			return Math.sqrt(Math.pow((other.midX - midX),2) + Math.pow((other.midY - midY),2));
		}
		
		public function angleTo(other:IRect):Number
		{
			return Math.atan2(other.midY - midY, other.midX - midX);
		}
		
		public function moveTo(other:IRect):void
		{
			midX = other.midX;
			midY = other.midY;
		}
		
		public function moveToward(other:IRect, dist:Number):void
		{
			var range:Number = rangeTo(other);
			var angle:Number = angleTo(other);
			
			if(dist > range){ dist = range; }

			moveAtAngle(angle, dist);
		}
		
		public function moveAtAngle(angle:Number, dist:Number):void
		{
			x += Math.cos(angle) * dist;
			y += Math.sin(angle) * dist;
		}
		
		// Extra aliases for compatibility
		public function get width():Number{ return w; }
		public function get height():Number{ return h; }
		public function set width(n:Number):void{ w = n; }
		public function set height(n:Number):void{ h = n; }
	}
}
