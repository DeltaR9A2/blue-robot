package
{
	import org.flixel.*;
	
	public class Firearm extends BaseWeapon implements IWeapon
	{
		public var shotSound:Class = null;
		public var bulletType:Class = HarmfulDot;

		public var firing:Boolean = false;
		public var shotTimer:Number = 0.0;
		public var shotsFired:Number = 0.0;
		public var rateOfFire:Number = 1.0;
		public var bulletsPerShot:Number = 1.0;

		public function Firearm(owner:FlxBasic)
		{
			this.owner = owner;
		}
		
		public function startAttacking():void
		{
			firing = true;
			shotTimer = 0;
			shotsFired = 0;
		}
		
		public function stopAttacking():void
		{
			firing = false;
		}
		
		public function isAttacking():Boolean{ return firing; }
		public function readyToAttack():Boolean{ return shotTimer <= 0.0; }
		
		public function onContact(x:FlxObject):Boolean
		{
			return false;
		}
		
		override public function update():void
		{
			if(shotTimer > 0){
				shotTimer -= FlxG.elapsed;
			}else if(this.firing){
				onAttack();
				shotTimer = 1.0 / rateOfFire;
			}else{
				
			}
		}
			
		public function onAttack():void
		{
			for(var n:int = 0; n < bulletsPerShot; n++){
				Bullet.addBullet(bulletType, source, target, owner);
			}
			FlxG.play(shotSound);
		}
	}
}
