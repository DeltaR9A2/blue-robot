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
	
	public class MainMenu extends FlxState
	{
		public var title:FlxText = null;
		public var buttons:Array = null;
		
		override public function create():void
		{
			var padding:Number = 5;
			
			title = new FlxText(0, padding, FlxG.width, "Blue Robot");
			title.setFormat.apply(title, Main.titleStyle);
			add(title);
			
			buttons = new Array;
			
			buttons.push(new FlxButton(0,0,"Start Game",function():void{ FlxG.fade(0xFF000000, Main.fadeTime, Main.startNewGame); }));
			buttons.push(new FlxButton(0,0,"How to Play",function():void{ FlxG.switchState(new HowToPlay); }));
			//buttons.push(new FlxButton(0,0,"Options",function():void{ }));
			buttons.push(new FlxButton(0,0,"Credits",function():void{ FlxG.switchState(new Credits); }));
			buttons.push(new FlxButton(0,0,"Mission Test",function():void{ FlxG.switchState(new MissionSelect);}));

			var yPos:Number = title.h + (2*padding);
			for each(var button:FlxButton in buttons)
			{
				button.tEdge = yPos;
				button.midX = FlxG.width>>1;
				add(button);
				
				yPos += (button.h + padding);
			}
			
			FlxG.mouse.show();
			FlxG.flash(0xFFFFFFFF, Main.fadeTime);
		}
	}
}
