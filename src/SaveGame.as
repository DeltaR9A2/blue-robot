package
{
	import org.flixel.*;
	
	public class SaveGame
	{
		public var saveData:Object = null;

		public var flxSave:FlxSave = null;
		public var saveBound:Boolean = false;
		
		public function SaveGame(saveName:String)
		{
			flxSave = new FlxSave;
			saveBound = flxSave.bind("BlueRobot-" + saveName);
			
			if(saveBound){
				if(flxSave.data.data == null){
					saveData = {};
					flxSave.data.data = saveData;
				}else{
					saveData = flxSave.data.data;
				}
			}else{
				saveData = {};
			}
		}
		
		public function flush():void
		{
			flxSave.flush();
		}
	}
}
