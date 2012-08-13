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
	
	public class StatusMessage extends FlxText
	{
		public var lifespan:Number = 5.0;
		
		public function StatusMessage(text:String="Status Message Not Set")
		{
			super(0,0,320,text);
			size = 8;
			alignment = "center";
			
			scrollFactor.x = 0;
			scrollFactor.y = 0;
		}
		
		
		override public function update():void
		{
			super.update();
			
			lifespan -= FlxG.elapsed;
			if(lifespan < 0){
				this.kill();
			}
		}
	}
}
