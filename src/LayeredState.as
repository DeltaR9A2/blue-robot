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
	
	import flash.utils.ByteArray;

	public class LayeredState extends FlxState
	{
		public static const BGTILES:uint =  10;
		public static const TERRAIN:uint =  20;
		public static const BRIDGES:uint =  30;
		public static const ACTIVES:uint =  40;
		public static const SCENERY:uint =  50;
		public static const EFFECTS:uint =  60;
		public static const ENEMIES:uint =  70;
		public static const PLAYERS:uint =  80;
		public static const BULLETS:uint =  90;
		public static const PICKUPS:uint = 100;
		public static const FGTILES:uint = 110;
		public static const DISPLAY:uint = 120;
		
		public var layers:Array = null;
		
		public function makeLayers():void
		{
			layers = new Array;
			layers[BGTILES] = new FlxGroup;
			layers[TERRAIN] = new FlxGroup;
			layers[BRIDGES] = new FlxGroup;
			layers[ACTIVES] = new FlxGroup;
			layers[SCENERY] = new FlxGroup;
			layers[EFFECTS] = new FlxGroup;
			layers[ENEMIES] = new FlxGroup;
			layers[PLAYERS] = new FlxGroup;
			layers[BULLETS] = new FlxGroup;
			layers[PICKUPS] = new FlxGroup;
			layers[FGTILES] = new FlxGroup;
			layers[DISPLAY] = new FlxGroup;

			for(var i:int = 0; i < layers.length; i++){
				if(layers[i] == null){ continue; }
				add(layers[i]);
			}
		}
		
		public function clearLayers():void
		{
			callAll("destroy");
		}
		
		public function resetLayers():void
		{
			clearLayers();
			makeLayers();
		}
		
		public function get actives():FlxGroup{ return layers[ACTIVES]; }
		public function get bgtiles():FlxGroup{ return layers[BGTILES]; }
		public function get bridges():FlxGroup{ return layers[BRIDGES]; }
		public function get bullets():FlxGroup{ return layers[BULLETS]; }
		public function get display():FlxGroup{ return layers[DISPLAY]; }
		public function get effects():FlxGroup{ return layers[EFFECTS]; }
		public function get enemies():FlxGroup{ return layers[ENEMIES]; }
		public function get fgtiles():FlxGroup{ return layers[FGTILES]; }
		public function get pickups():FlxGroup{ return layers[PICKUPS]; }
		public function get players():FlxGroup{ return layers[PLAYERS]; }
		public function get scenery():FlxGroup{ return layers[SCENERY]; }
		public function get terrain():FlxGroup{ return layers[TERRAIN]; }
	}
}
