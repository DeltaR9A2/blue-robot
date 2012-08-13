package
{
	import org.flixel.*;
	
	public class SaveGame
	{
		public var data:Object = null;

		public var flxSave:FlxSave = null;
		public var saveBound:Boolean = false;
		
		public function SaveGame(saveName:String)
		{
			flxSave = new FlxSave;
			saveBound = flxSave.bind("BlueRobot-" + saveName);
			
			if(saveBound){
				if(flxSave.data.data == null){
					data = {};
					flxSave.data.data = data;
				}else{
					data = flxSave.data.data;
				}
			}else{
				data = {};
			}
		}
		
		public function flush():void
		{
			flxSave.flush();
		}
	}
}
