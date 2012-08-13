package
{
	import org.flixel.*;
	
	public class Crosshair extends FlxSprite
	{
		[Embed(source="../data/images/crosshair.png", mimeType="image/png")] public static const CrosshairPNG:Class;
		
		public function Crosshair()
		{
			loadGraphic(CrosshairPNG, false, false);
			alpha = 0.5;
		}
		
		override public function update():void
		{
			moveTo(FlxG.mouse);
			
			if(Main.player.weapon != null && Main.player.weapon.readyToAttack()){
				color = 0x00FF00;
			}else{
				color = 0xFF0000;
			}
		}
	}
}
