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
	
	public class TextDisplay extends HUDElement
	{
		public static const padding:Number = 2;
		
		private var _text:FlxText = null;
		
		public var duration:Number = 0.0;
		public var timer:Number = 0.0;
		
		public function TextDisplay()
		{
			_text = new FlxText(0, 0, FlxG.width, "Blank Message");
			_text.color = 0xFFDD00;
			_text.shadow = 0xFF000000;
			_text.alignment = "center";
			_text.scrollFactor.x = 0;
			_text.scrollFactor.y = 0;
			
			super(_text.width, 8 + (2*padding));
			
			add(_text);
		}
		
		public function get text():String{ return _text.text; }
		public function set text(t:String):void{ _text.text = t; timer = 0.0; }
		
		override public function syncX():void{
			super.syncX();
			_text.x = bg.x;
		}
		
		override public function syncY():void{
			super.syncY();
			_text.y = bg.y + ((bg.height - _text.height)>>1);
		}
		
		override public function update():void
		{
			if(duration > 0){
				if(timer > duration){
					this.visible = false;
				}else{
					this.visible = true;
					timer += FlxG.elapsed;
				}
			}else{
				if(text == ""){
					this.visible = false;
				}else{
					this.visible = true;
				}
			}
			
			super.update();
		}
	}
}
