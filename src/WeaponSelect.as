package
{
	import org.flixel.*;
	
	public class WeaponSelect extends HUDElement
	{
		[Embed(source="../data/images/weaponSelectRifle.png", mimeType="image/png")]
			public static const RifleSelectPNG:Class;
		[Embed(source="../data/images/weaponSelectShotgun.png", mimeType="image/png")]
			public static const ShotgunSelectPNG:Class;
		[Embed(source="../data/images/weaponSelectBlaster.png", mimeType="image/png")]
			public static const BlasterSelectPNG:Class;

		public var weaponSelectSprites:Vector.<FlxSprite> = null;
		public var rifleSelectSprite:FlxSprite = null;
		public var shotgunSelectSprite:FlxSprite = null;
		public var blasterSelectSprite:FlxSprite = null;
		
		public function WeaponSelect()
		{
			weaponSelectSprites = new Vector.<FlxSprite>(3);
			weaponSelectSprites[Player.RIFLE] = new FlxSprite(0,0,RifleSelectPNG);
			weaponSelectSprites[Player.SHOTGUN] = new FlxSprite(0,0,ShotgunSelectPNG);
			weaponSelectSprites[Player.BLASTER] = new FlxSprite(0,0,BlasterSelectPNG);

			var maxH:int = 0;
			var s:FlxSprite = null;
			for each(s in weaponSelectSprites)
			{
				s.alpha = 0.75;
				s.scrollFactor.x = 0;
				s.scrollFactor.y = 0;
				maxH = Math.max(maxH, s.h);
			}

			super(FlxG.width, maxH);

			for each(s in weaponSelectSprites){ add(s); }
		}

		override public function syncX():void{
			super.syncX();
			
			var curX:int = bg.lEdge;
			
			for each(var s:FlxSprite in weaponSelectSprites)
			{
				s.lEdge = curX;
				curX = s.rEdge;
			}
		}
		
		override public function syncY():void{
			super.syncY();
			
			for each(var s:FlxSprite in weaponSelectSprites)
			{
				s.tEdge = bg.tEdge;
			}
		}
		
		override public function update():void{
			for(var i:uint = 0; i < weaponSelectSprites.length; i++){
				if(i == Main.player.weaponIndex){
					weaponSelectSprites[i].color = 0x33FF33;
				}else{
					weaponSelectSprites[i].color = 0x999999;
				}
			}
		}
	}
}
