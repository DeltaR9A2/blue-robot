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
	
	public class Coin extends Pickup
	{
		[Embed(source="../data/images/pickupCoins.png", mimeType="image/png")] public static const SpriteSheet:Class;
		[Embed(source="../data/sounds/coin.mp3", mimeType="audio/mpeg")] private static const CollectSound:Class;
		
		public static const COPPER:int = 1;
		public static const SILVER:int = 10;
		public static const GOLD:int = 100;
		public static const PLATINUM:int = 1000;

		public var _value:int = 0;
		
		public function Coin(element:XML=null)
		{
			loadGraphic(SpriteSheet, true, false, 8, 8);
			addAnimation("gold",[0,1,2,3,4,5,6,7], 5, true);
			addAnimation("silver",[8,9,10,11,12,13,14,15], 5, true);
			addAnimation("copper",[16,17,18,19,20,21,22,23], 5, true);
			addAnimation("blue",[24,25,26,27,28,29,30,31], 5, true);

			stationary = false;
			elasticity = 0.4;
			drag.x = 50;

			acceleration.y = 200;
			maxVelocity.y = 200;
			
			if(element != null){
				x = element.@x;
				y = element.@y;
				value = element.@value;
			}else{
				value = COPPER;
			}
		}
		
		public function set value(x:int):void
		{
			_value = x;
			
			if(_value < SILVER){
				play("copper");
			}else if(_value < GOLD){
				play("silver");
			}else if(_value < PLATINUM){
				play("gold");
			}else{
				play("blue");
			}
		}
		
		public function get value():int
		{
			return _value;
		}
		
		override public function onCollect():void
		{
			Main.player.money += this._value;
			FlxG.play(CollectSound);
		}
		
		public static function coinBurst(count:int, value:Number, where:Rect):void
		{
			var valueRemaining:Number = value;
			
			for(var i:int = 0; i < count; i++){
				var coin:Coin = Main.level.pickups.recycle(Coin) as Coin;
				coin.reset(where.x, where.y);
				var angle:Number = FlxG.random()*(2*Math.PI);
				coin.velocity.x = 128*Math.cos(angle);
				coin.velocity.y = 128*Math.sin(angle);
				coin.value = value;
			}
		}
	}
}
