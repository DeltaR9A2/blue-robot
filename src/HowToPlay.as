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
	
	public class HowToPlay extends FlxState
	{
		[Embed(source="../data/images/howToPlay.png", mimeType="image/png")] public static const HowToPlayPNG:Class;
		
		public var graphic:FlxSprite = null;
		public var button:FlxButton = null;
		
		override public function create():void
		{
			var padding:Number = 5;
			
			graphic = new FlxSprite(0,0,HowToPlayPNG);
			button = new FlxButton(0,0,"Back",function():void{ FlxG.switchState(new MainMenu); });
			
			button.x = FlxG.width - (padding + button.w);
			button.y = FlxG.height - (padding + button.h);
			
			add(graphic);
			add(button);
			
			FlxG.mouse.show();
			FlxG.flash(0xFFFFFFFF, Main.fadeTime);
		}
	}
}
