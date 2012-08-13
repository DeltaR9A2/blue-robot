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
	
	import flash.globalization.CurrencyFormatter;
	
	public class CoinDisplay extends HUDElement
	{
		public var coinIcon:FlxSprite = null;
		public var coinLabel:FlxText = null;
		public var formatter:CurrencyFormatter = new CurrencyFormatter("en-US");
		
		public function CoinDisplay()
		{
			coinIcon = new FlxSprite;
			coinIcon.loadGraphic(Coin.SpriteSheet, true, false, 8, 8);
			coinIcon.addAnimation("gold", [0, 1, 2, 3, 4, 5, 6, 7], 5, true);
			coinIcon.play("gold");
			coinIcon.scrollFactor.x = 0;
			coinIcon.scrollFactor.y = 0;
			
			coinLabel = new FlxText(0,0,48,"$00.00");
			coinLabel.color = 0x119911;
			coinLabel.shadow = 0xFF000000;
			coinLabel.alignment = "right";
			coinLabel.scrollFactor.x = 0;
			coinLabel.scrollFactor.y = 0;

			var bgW:int = coinLabel.width + coinIcon.width + (padding*3);
			var bgH:int = 8 + (padding*2);

			super(bgW, bgH);
			
			add(coinIcon);
			add(coinLabel);
		}

		override public function syncX():void{
			super.syncX();
			coinIcon.x = bg.x + padding;
			coinLabel.x = bg.x + coinIcon.width + (padding*2);
		}
		
		override public function syncY():void{
			super.syncY();
			coinIcon.y = bg.y + ((bg.height - coinIcon.height)/2);
			coinLabel.y = bg.y + ((bg.height - coinLabel.height)/2);
		}
		
		override public function update():void
		{
			if(Main.player != null){
				coinLabel.text = formatter.format(Main.player.money/100, true);
			}
			
			super.update();
		}
	}
}
