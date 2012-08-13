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
	
	public class Credits extends FlxState
	{
		[Embed(source="../data/images/creditsFoxSynergy.png", mimeType="image/png")]
			public static const FoxSynergyPNG:Class;
		[Embed(source="../data/images/creditsFatCow.png", mimeType="image/png")]
			public static const FatCowPNG:Class;
		[Embed(source="../data/images/creditsJohnColburn.png", mimeType="image/png")]
			public static const JohnColburnPNG:Class;
			
		public var title:FlxText = null;
		
		public var foxSynergyCredit:CreditsEntry = null;
		public var fatCowCredit:CreditsEntry = null;
		public var johnColburnCredit:CreditsEntry = null;
		
		public var backButton:FlxButton = null;
		
		override public function create():void
		{
			var padding:Number = 5;
			
			title = new FlxText(0, padding, FlxG.width, "Who is responsible for this nonsense?");
			title.setFormat.apply(title, Main.subtitleStyle);
			add(title);

			johnColburnCredit = add(new CreditsEntry(
				JohnColburnPNG,
				"John Colburn",
				"Most of the game",
				"http://spacecolonygames.com/"
			)) as CreditsEntry;

			foxSynergyCredit = add(new CreditsEntry(
				FoxSynergyPNG,
				"FoxSynergy",
				"Awesome music",
				"http://opengameart.org/users/foxsynergy/"
			)) as CreditsEntry;
			
			fatCowCredit = add(new CreditsEntry(
				FatCowPNG,
				"FatCow Webhosting",
				"Various icons",
				"http://www.fatcow.com/free-icons/"
			)) as CreditsEntry;
			
			johnColburnCredit.lEdge = padding;
			johnColburnCredit.tEdge = title.bEdge + padding;

			foxSynergyCredit.lEdge = padding;
			foxSynergyCredit.y = johnColburnCredit.bEdge + padding;
			
			fatCowCredit.lEdge = padding;
			fatCowCredit.y = foxSynergyCredit.bEdge + padding;

			backButton = new FlxButton(0,0,"Back",function():void{ FlxG.switchState(new MainMenu); });
			backButton.rEdge = FlxG.width - padding;
			backButton.bEdge = FlxG.height - padding;
			add(backButton);
			
			FlxG.flash(0xFFFFFFFF, Main.fadeTime);
		}
	}
}
