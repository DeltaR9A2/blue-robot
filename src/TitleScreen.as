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
	
	public class TitleScreen extends FlxState
	{
		public var title:FlxText = null;
		public var subtitle:FlxText = null;
		public var instructions:FlxText = null;
		override public function create():void
		{
			var padding:Number = 5;
			
			title = new FlxText(0, padding, FlxG.width, "Blue Robot");
			title.setFormat.apply(title, Main.titleStyle);

			subtitle = new FlxText(0, title.height + (padding*2), FlxG.width, "Version Alpha-3");
			subtitle.setFormat.apply(title, Main.subtitleStyle);
			
			instructions = new FlxText(0, 0, FlxG.width, "Click to Play");
			instructions.setFormat.apply(title, Main.subtitleStyle);
			instructions.y = FlxG.height - (padding + instructions.h);
			
			add(title);
			add(subtitle);
			add(instructions);

			FlxG.mouse.show();
		}
		
		override public function update():void
		{
			if(FlxG.mouse.justPressed()){
				FlxG.switchState(new MainMenu);
			}
		}
	}
}
