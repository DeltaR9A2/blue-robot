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
	
	public class FlyText extends FlxText
	{
		public var lifespan:Number = 120;
		
		public function FlyText(text:String="---")
		{
			super(0,0,32,text);
			size = 8;
			alignment = "center";
		}
		
		override public function update():void
		{
			super.update();
			
			lifespan -= 1;
			if(lifespan < 0){
				this.kill();
			}
		}
		
		public static function flyText(location:IRect, text:String, color:uint):void
		{
			if(FlxG.state is Level){
				var level:Level = FlxG.state as Level;
				var flyText:FlyText = level.display.recycle(FlyText) as FlyText;
				flyText.revive();
				flyText.moveTo(location);
				flyText.text = text;
				flyText.color = color;
				flyText.shadow = 0xFF000000;
				flyText.lifespan = 60;
				flyText.velocity.y = -50;
			}
		}
	}
}
