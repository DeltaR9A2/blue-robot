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
	public class GameOver extends FlxState
	{
		public var text:FlxText = null;
		public var status:FlxText = null;

		public var timeOut:Number = 10.0;
		
		override public function create():void
		{
			text = new FlxText(0, 10, 320, "Game Over");
			text.size = 16;
			text.alignment = "center";
			this.add(text);
			
			status = new FlxText(0, 200, 320, "Game will reset in " + Math.round(timeOut).toString() + " seconds.");
			status.alignment = "center";
			this.add(status);
		}
		
		override public function update():void
		{
			if(timeOut > 0){
				timeOut -= FlxG.elapsed;
				status.text = "Game will reset in " + Math.round(timeOut).toString() + " seconds.";
			}else{
				FlxG.resetGame();
			}
		}
	}
}
