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
	
	public class HealthDisplay extends HUDElement
	{
		[Embed(source="../data/images/pickupHearts.png", mimeType="image/png")] public static const SpriteSheet:Class;
	
		public static const padding:Number = 2;
		
		public var hearts:Vector.<FlxSprite> = null;
		public var pulseTimer:Number = 0.0;
		public var pulseIndex:int = 0;
		
		public function HealthDisplay()
		{
			var numHearts:int = Main.player.maxHealth;
			var heartsWidth:int = (numHearts-1) * padding;
			
			hearts = new Vector.<FlxSprite>(numHearts, true);
			
			var heart:FlxSprite;
			for(i = 0; i < hearts.length; i++){
				heart = new FlxSprite;
				heart.loadGraphic(SpriteSheet, true, false);
				heart.addAnimation("full", [0], 1, false);
				heart.addAnimation("flash", [1], 1, false);
				heart.addAnimation("empty", [2], 1, false);
				heart.scrollFactor.x = 0;
				heart.scrollFactor.y = 0;
				heartsWidth += heart.width;
				hearts[i] = heart;
			}
			
			var bgW:int = heartsWidth + (padding*2);
			var bgH:int = 8 + (padding*2);

			super(bgW, bgH);
			
			for(var i:int = 0; i < hearts.length; i++){
				add(hearts[i]);
			}
		}
		
		override public function syncX():void{
			super.syncX();
			for(var i:int = 0; i < hearts.length; i++){
				hearts[i].x = bg.x + padding + ((hearts[i].height + padding) * i);
			}
		}
		
		override public function syncY():void{
			super.syncY();
			for(var i:int = 0; i < hearts.length; i++){
				hearts[i].y = bg.y + padding;
			}
		}
		
		public function updateLogic():void
		{
			var pulseDelay:Number = 3.0 * (Main.player.curHealth / Main.player.maxHealth);
			pulseTimer += FlxG.elapsed;
			
			if(pulseTimer < pulseDelay){
				pulseIndex = -1;
			}else{
				pulseIndex = (pulseTimer - pulseDelay) / 0.1;
				
				if(pulseIndex > Main.player.curHealth){
					pulseTimer -= pulseDelay;
					pulseIndex = -1;
				}
			}
		}

		public function animSelect():void
		{
			for(var i:int = 0; i < hearts.length; i++)
			{
				if(i < Main.player.curHealth && i == pulseIndex){
					hearts[i].play("flash");
				}else if(i < Main.player.curHealth){
					hearts[i].play("full");
				}else{
					hearts[i].play("empty");
				}
			}
		}
			
		override public function update():void
		{
			updateLogic();
			animSelect();
			super.update();
		}
	}
}
