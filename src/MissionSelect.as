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
	
	public class MissionSelect extends FlxState
	{
		public var title:FlxText = null;
		public var missionButtons:FlxGroup = null;
		
		override public function create():void
		{
			var padding:Number = 5;
			
			title = new FlxText(0, padding, FlxG.width, "Mission Select");
			title.setFormat.apply(title, Main.titleStyle);

			add(title);

			missionButtons = new FlxGroup;
			var yPos:Number = title.bEdge + padding;
			for each(var mission:String in ["Mission One","Mission Two","Mission Threeeeeee"])
			{
				var button:FlxButton = new FlxButton(0,yPos,mission,function():void{});
				button.w = FlxG.width/2;
				missionButtons.add(button);
				yPos = button.bEdge;
			}
			
			add(missionButtons);
			
			FlxG.mouse.show();
		}
	}
}
