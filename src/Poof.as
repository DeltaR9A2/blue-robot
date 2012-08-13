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
	
	public class Poof extends FlxSprite
	{
		[Embed(source="../data/images/effectExplodePoof.png", mimeType="image/png")] public static var PoofPNG:Class;
		[Embed(source="../data/sounds/explode.mp3", mimeType="audio/mpeg")] private static var PoofMP3:Class;
		
		public function Poof()
		{
			loadGraphic(PoofPNG, true, false, 37, 37);
			addAnimation("poof", [0,1,2,3,4,5,6], 15, false);
		}
		
		override public function update():void
		{
			if(this.frame > 5){
				this.kill();
			}
		}
		
		override public function reset(x:Number, y:Number):void
		{
			super.reset(x - (this.width/2), y - (this.height/2));
			this.play("poof", true);
			FlxG.play(PoofMP3);
		}
		
		public static function poof(location:IRect):void
		{
			if(FlxG.state is Level){
				var level:Level = FlxG.state as Level;
				var poof:Poof = level.effects.recycle(Poof) as Poof;
				poof.reset(location.midX, location.midY);
			}
		}
	}
}
