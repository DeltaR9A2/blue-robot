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

	public class Level extends LayeredState
	{
		[Embed(source="../data/music/Datastream_Goddess.mp3", mimeType="audio/mpeg")]
			public static const MusicMP3:Class;

		[Embed(source="../data/maps/level_001.oel", mimeType="application/octet-stream")]
			public static const Level001XML:Class;
		[Embed(source="../data/maps/level_002.oel", mimeType="application/octet-stream")]
			public static const Level002XML:Class;
		[Embed(source="../data/maps/level_002_storage.oel", mimeType="application/octet-stream")]
			public static const Level002AXML:Class;

		public static var fullList:Vector.<Level> = new Vector.<Level>;
		public static var byDoorName:Object = null;
		
		public var loaded:Boolean = false;
		public var visited:Boolean = false;
		
		public var flightCollision:FlxGroup = null;
		
		public var levelWidth:int = 0;
		public var levelHeight:int = 0;

		public var backgroundMap:FlxTilemap = null;
		public var terrainMap:FlxTilemap = null;
		public var bridgesMap:FlxTilemap = null;
		public var sceneryMap:FlxTilemap = null;
		public var foregroundMap:FlxTilemap = null;
		
		public function loadLevel(rawXML:Class):void
		{
			var xmlBytes:ByteArray = new rawXML;
			var xmlString:String = xmlBytes.readUTFBytes(xmlBytes.length);
			var xmlData:XML = new XML(xmlString);
			var element:XML = null;
			
			resetLayers();
			
			levelWidth = xmlData.@width;
			levelHeight = xmlData.@height;
			
			backgroundMap = new TileLayer(xmlData.background.tile);
			terrainMap = new TileLayer(xmlData.terrain.tile);
			bridgesMap = new TileLayer(xmlData.bridges.tile);
			sceneryMap = new TileLayer(xmlData.decorations.tile);
			foregroundMap = new TileLayer(xmlData.foreground.tile);
			
			bgtiles.add(backgroundMap);
			terrain.add(terrainMap);
			bridges.add(bridgesMap);
			scenery.add(sceneryMap);
			fgtiles.add(foregroundMap);
			
			for each (element in (xmlData.entities.children())){
				loadEntity(element);
			}
			
			if(flightCollision != null)
			{
				remove(flightCollision);
				flightCollision.destroy();
			}
			
			flightCollision = new FlxGroup;
			add(flightCollision);
			
			for each (element in xmlData.flightCollision.rect){
				var rect:FlxObject = new FlxObject;
				rect.x = element.@x;
				rect.y = element.@y;
				rect.w = element.@w;
				rect.h = element.@h;
				rect.solid = true;
				rect.immovable = true;
				flightCollision.add(rect);
			}
			
			Level.fullList.push(this);
			
			loaded = true;
		}

		public function loadEntity(element:XML):void
		{
			var eName:String = element.name().localName;
			
			if(eName == "door"){
				var door:Door = new Door(element);
				Level.byDoorName[door.doorName] = this;
				actives.add(door);
				
			}else if(eName == "bee"){
				enemies.add(new Bee(element));
				
			}else if(eName == "bigBee"){
				enemies.add(new BigBee(element));
				
			}else if(eName == "turret"){
				enemies.add(new Turret(element));
				
			}else if(eName == "key"){
				pickups.add(new Key(element));
				
			}else if(eName == "heart"){
				pickups.add(new Heart(element));
				
			}else if(eName == "coin"){
				pickups.add(new Coin(element));
				
			}else{
				trace("Unknown entity added to level: " + element.toXMLString());
			}
		}
		
		override public function create():void
		{
			if(!loaded){ throw new Error("Error: Entering a level before it's loaded!"); }
			
			Main.level = this;
			
			players.add(Main.player);
			display.add(Main.hud);
			
			terrainMap.follow();
			
			FlxG.camera.target = Main.player;
			
			FlxG.flash(0xFF000000, Main.fadeTime);
		}
		
		override public function destroy():void
		{
			players.remove(Main.player);
			display.remove(Main.hud);
		}
		
		override public function update():void
		{
			super.update();
			
			// Player Collisions
			FlxG.collide(players, terrain);
			FlxG.overlap(players, bridges, FlxObject.separate, Player.bridgeTest);
			FlxG.overlap(players, enemies, Monster.touchOfDeath);
			FlxG.overlap(players, actives, Active.findTargetActive);
			
			// Pickup collisions.
			FlxG.collide(pickups, terrain);
			FlxG.collide(pickups, bridges);

			// Bullet collisions.
			FlxG.overlap(bullets, enemies, Bullet.bulletHit);
			FlxG.overlap(bullets, players, Bullet.bulletHit);
			FlxG.overlap(bullets, terrain, Bullet.bulletHit, FlxObject.separate);

			// Flight collisions.
			FlxG.collide(enemies, flightCollision);
		}
	}
}
