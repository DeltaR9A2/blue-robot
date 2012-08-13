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
	public interface IRect
	{
		function get x():Number;
		function get y():Number;
		function set x(n:Number):void;
		function set y(n:Number):void;
		
		function get midX():Number;
		function get midY():Number;
		function set midX(n:Number):void;
		function set midY(n:Number):void;
		
		function get lEdge():Number;
		function get rEdge():Number;
		function set lEdge(n:Number):void;
		function set rEdge(n:Number):void;

		function get tEdge():Number;
		function get bEdge():Number;
		function set tEdge(n:Number):void;
		function set bEdge(n:Number):void;
		
		function rangeTo(other:IRect):Number;
		function angleTo(other:IRect):Number;
		
		function moveTo(other:IRect):void;
		function moveToward(other:IRect, dist:Number):void;
		function moveAtAngle(angle:Number, dist:Number):void;
	}
}
