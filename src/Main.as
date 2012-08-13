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
	
	[SWF(width="640",height="480",backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class Main extends FlxGame
	{
		[Embed(source="../data/fonts/CarterOne.ttf", fontName="CarterOne", embedAsCFF=false)] public static const CarterOne:Class;
		public static const titleStyle:Array = ["CarterOne", 32, 0xFFFFFF, "center", 0xFF000000];
		public static const subtitleStyle:Array = ["CarterOne", 16, 0xFFFFFF, "center", 0xFF000000];
		
		public static const radToDeg:Number = (180.0/Math.PI);
		public static const degToRad:Number = (Math.PI/180.0);

		public static const fadeTime:Number = 0.50;
		
		public static var player:Player = null;
		public static var level:Level = null;
		
		public function Main()
		{
			super(320, 240, TitleScreen, 2);
			forceDebugger = true;
		}
	}
}
