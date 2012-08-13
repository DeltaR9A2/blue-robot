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
	
	public class TileLayer extends FlxTilemap
	{
		[Embed(source="../data/images/tiles.png", mimeType="image/png")]
			public static const TilesetPNG:Class;

		public var width_in_tiles:int  = 0;
		public var height_in_tiles:int = 0;
		
		public function TileLayer(elements:XMLList)
		{
			var element:XML = null;

			var xMax:int = 1;
			var yMax:int = 1;
			for each (element in elements)
			{
				var x:int = element.@x;
				var y:int = element.@y;
				xMax = Math.max(xMax, x);
				yMax = Math.max(yMax, y);
			}
			
			this.width_in_tiles = xMax+1;
			this.height_in_tiles = yMax+1;
			
			var tiles:Array = new Array;
			for each (element in elements)
			{
				var index:Number = tilesToIndex(element.@x, element.@y);
				tiles[index] = int(element.@id);
			}
			
			for(var i:int = 0; i < (width_in_tiles * height_in_tiles); i++){
				if(tiles[i] == null){ tiles[i] = 0; }
			}
			
			var mapCSV:String = FlxTilemap.arrayToCSV(tiles, this.width_in_tiles, false);
			
			this.loadMap(mapCSV, TilesetPNG, 16, 16, OFF,  0, 1, 48);
			
			this.setTileProperties(0, NONE, null, null, 48);
			this.setTileProperties(48, ANY,  null, null, 48);
			this.setTileProperties(96, UP,   null, null, 48);
		}
		
		public function tilesToIndex(x:int, y:int):int{
			return (x + (y * this.width_in_tiles));
		}
	}
}
