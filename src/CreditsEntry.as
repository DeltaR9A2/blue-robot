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
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	import org.flixel.*;
	
	public class CreditsEntry extends FlxGroup
	{
		public static const padding:Number = 5;
		
		public var image:FlxSprite = null;
		public var nameLabel:FlxText = null;
		public var creditLabel:FlxText = null;
		public var urlButton:FlxButton = null;
		public var urlRequest:URLRequest = null;
		
		public function CreditsEntry(rawImage:Class, name:String, credit:String, url:String):void
		{
			setSize(FlxG.width, FlxG.height/4);
			
			image = add(new FlxSprite(0,0,rawImage)) as FlxSprite;
			creditLabel = add(new FlxText(0,0,200,credit)) as FlxText;
			nameLabel = add(new FlxText(0,0,200,"by " + name)) as FlxText;
			urlButton = add(new FlxButton(0,0,"website",goToURL)) as FlxButton;
			urlRequest = new URLRequest(url);
			
			w = image.w + nameLabel.w + (padding*3);
		}
		
		public function goToURL():void
		{
			navigateToURL(urlRequest, "_blank");
		}
		
		public function syncX():void
		{
			image.lEdge = lEdge + padding;
			creditLabel.lEdge = image.rEdge + padding;
			nameLabel.lEdge = image.rEdge + padding;
			urlButton.lEdge = image.rEdge + padding;
		}
		
		public function syncY():void
		{
			image.tEdge = tEdge + padding;
			creditLabel.tEdge = tEdge + padding;
			nameLabel.tEdge = creditLabel.bEdge + padding;
			urlButton.tEdge = nameLabel.bEdge + padding;
		}
	}
}
