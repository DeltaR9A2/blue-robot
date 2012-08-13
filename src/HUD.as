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
	public class HUD extends FlxGroup
	{
		public static const padding:Number = 2;
		
		public var coinDisplay:CoinDisplay = null;
		public var healthDisplay:HealthDisplay = null;
		public var statusMessage:TextDisplay = null;
		public var contextMessage:TextDisplay = null;
		public var weaponSelect:WeaponSelect = null;
		
		public var bottomFiller:HUDElement = null;
		
		public var crosshair:Crosshair = null;
		
		public function HUD()
		{
			setRect(FlxG.width, FlxG.height);
			
			coinDisplay = new CoinDisplay;
			coinDisplay.lEdge = 0;
			coinDisplay.bEdge = FlxG.height;
			
			healthDisplay = new HealthDisplay;
			healthDisplay.lEdge = coinDisplay.rEdge;
			healthDisplay.bEdge = FlxG.height;
			
			bottomFiller = new HUDElement(FlxG.width - (coinDisplay.width + healthDisplay.width), 8 + 2*padding);
			bottomFiller.lEdge = healthDisplay.rEdge;
			bottomFiller.bEdge = FlxG.height;

			weaponSelect = new WeaponSelect;
			weaponSelect.lEdge = 0;
			weaponSelect.tEdge = 0;
			
			statusMessage = new TextDisplay;
			statusMessage.lEdge = 0;
			statusMessage.tEdge = weaponSelect.bEdge;
			statusMessage.text = "";
			statusMessage.duration = 3.0;
			statusMessage.timer = 6.0;
			
			contextMessage = new TextDisplay;
			contextMessage.lEdge = 0;
			contextMessage.bEdge = healthDisplay.tEdge;
			contextMessage.text = "";
			contextMessage.duration = 0.5;
			contextMessage.timer = 1.0;

			crosshair = new Crosshair;
			
			add(coinDisplay);
			add(healthDisplay);
			add(bottomFiller);
			
			add(weaponSelect);
			
			add(statusMessage);
			add(contextMessage);
			
			add(crosshair);
		}
	}
}
