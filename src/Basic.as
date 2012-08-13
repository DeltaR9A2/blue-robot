package
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import org.flixel.*;

	public class Basic extends Rect
	{
		static public const ASCENDING:int = -1;
		static public const DESCENDING:int = 1;

		static public var _ACTIVECOUNT:uint;
		static public var _VISIBLECOUNT:uint;

		public var members:Array;

		protected var _maxSize:uint;
		protected var _recycleMarker:uint;
		protected var _sortIndex:String;
		protected var _sortOrder:int;

		public var alive:Boolean;
		public var exists:Boolean;
		public var active:Boolean;

		private var _visible:Boolean;
		public function get visible():Boolean{ return _visible; }
		public function set visible(n:Boolean):void{ _visible = n; }

		public var cameras:Array;
		public var ignoreDrawDebug:Boolean;
		
		public function Basic()
		{
			exists = true;
			active = true;
			visible = true;
			alive = true;
			ignoreDrawDebug = false;

			scrollFactor = new Rect();
			scrollFactor.x = 1;
			scrollFactor.y = 1;
			
			members = new Array();
			_maxSize = 0;
			_recycleMarker = 0;
			_sortIndex = null;
		}

		public function destroy():void
		{
			if(members != null)
			{
				var basic:FlxBasic;
				var i:uint = 0;
				var l:uint = members.length;

				while(i < l)
				{
					basic = members[i++] as FlxBasic;
					if(basic != null)
						basic.destroy();
				}
				
				members.length = 0;
				members = null;
			}
			
			_sortIndex = null;
		}
		
		public function preUpdate():void
		{
			_ACTIVECOUNT++;
		}
		
		public function update():void
		{
			var basic:FlxBasic;
			var i:uint = 0;
			while(i < length)
			{
				basic = members[i++] as FlxBasic;
				if((basic != null) && basic.exists && basic.active)
				{
					basic.preUpdate();
					basic.update();
					basic.postUpdate();
				}
			}
		}
		
		public function postUpdate():void
		{
			
		}
		

		protected var _Rect:IRect;
		public var scrollFactor:IRect;
		
		public function getScreenXY(point:IRect=null,camera:FlxCamera=null):IRect
		{
			if(point == null)
				point = new Rect();
			if(camera == null)
				camera = FlxG.camera;
			point.x = x - int(camera.scroll.x*scrollFactor.x);
			point.y = y - int(camera.scroll.y*scrollFactor.y);
			point.x += (point.x > 0)?0.0000001:-0.0000001;
			point.y += (point.y > 0)?0.0000001:-0.0000001;
			return point;
		}

		public function onScreen(camera:FlxCamera=null):Boolean
		{
			if(_Rect == null){
				_Rect = new Rect();
			}
			if(camera == null)
				camera = FlxG.camera;
			getScreenXY(_Rect, camera);
			return (_Rect.x + width > 0) && (_Rect.x < camera.width) && (_Rect.y + height > 0) && (_Rect.y < camera.height);
		}

		public function draw():void
		{
			if(cameras == null){ cameras = FlxG.cameras; }
			
			var camera:FlxCamera;
			var basic:FlxBasic;
			var i:uint = 0;
			var l:uint = cameras.length;

			while(i < l)
			{
				camera = cameras[i++];

				if(!onScreen(camera))
					continue;

				_VISIBLECOUNT++;
				
				if(FlxG.visualDebug && !ignoreDrawDebug)
					drawDebug(camera);
			}
			
			while(i < length)
			{
				basic = members[i++] as FlxBasic;
				if((basic != null) && basic.exists && basic.visible)
					basic.draw();
			}
		}
		
		public function drawDebug(useCamera:FlxCamera=null):void
		{
			if(useCamera == null)
				useCamera = FlxG.camera;

			var boundingBoxX:Number = x - int(useCamera.scroll.x*scrollFactor.x);
			var boundingBoxY:Number = y - int(useCamera.scroll.y*scrollFactor.y);
			boundingBoxX = int(boundingBoxX + ((boundingBoxX > 0)?0.0000001:-0.0000001));
			boundingBoxY = int(boundingBoxY + ((boundingBoxY > 0)?0.0000001:-0.0000001));
			var boundingBoxWidth:int = (width != int(width))?width:width-1;
			var boundingBoxHeight:int = (height != int(height))?height:height-1;

			//fill static graphics object with square shape
			var gfx:Graphics = FlxG.flashGfx;
			gfx.clear();
			gfx.moveTo(boundingBoxX,boundingBoxY);
			var boundingBoxColor:uint;
/*			if(allowCollisions)
			{
				if(allowCollisions != ANY)
					boundingBoxColor = FlxG.PINK;
				if(immovable)
					boundingBoxColor = FlxG.GREEN;
				else
					boundingBoxColor = FlxG.RED;
			}
			else
				boundingBoxColor = FlxG.BLUE; */
			gfx.lineStyle(1,boundingBoxColor,0.5);
			gfx.lineTo(boundingBoxX+boundingBoxWidth,boundingBoxY);
			gfx.lineTo(boundingBoxX+boundingBoxWidth,boundingBoxY+boundingBoxHeight);
			gfx.lineTo(boundingBoxX,boundingBoxY+boundingBoxHeight);
			gfx.lineTo(boundingBoxX,boundingBoxY);
			
			//draw graphics shape to camera buffer
			useCamera.buffer.draw(FlxG.flashGfxSprite);
		}

		public function setRecursive(memberName:String, value:Object):void
		{
			var basic:Basic;
			var i:uint = 0;
			var l:uint = members.length;
			
			while(i < l)
			{
				basic = members[i++] as Basic;
				
				if(basic != null)
				{
					basic.setRecursive(memberName, value);
				}
			}
			
			this[memberName] = value;
		}
		
		public function callRecursive(methodName:String):void
		{
			var basic:Basic;
			var i:uint = 0;
			var l:uint = members.length;

			while(i < l)
			{
				basic = members[i++] as Basic;
				if(basic != null){
					basic.callRecursive(methodName);
				}
			}
			
			this[methodName]();
		}
		
		public function kill():void
		{
			alive = false;
			exists = false;
		}
		
		public function revive():void
		{
			alive = true;
			exists = true;
		}
		
		public function toString():String
		{
			return FlxU.getClassName(this, true);
		}
		
		public function get maxSize():uint
		{
			return _maxSize;
		}

		public function set maxSize(size:uint):void
		{
			_maxSize = size;

			if(
				_maxSize == 0 ||
				members == null ||
				_maxSize >= members.length
			){ return; }
			
			var basic:FlxBasic;
			var i:uint = _maxSize;
			var l:uint = members.length;

			while(i < l)
			{
				basic = members[i++] as FlxBasic;
				if(basic != null)
					basic.destroy();
			}
			
			members.length = _maxSize;
		}
		
		public function add(basic:FlxBasic):FlxBasic
		{
			if(members.indexOf(basic) >= 0){ return basic; }
			
			var i:uint = 0;
			var l:uint = members.length;
			while(i < l)
			{
				if(members[i] == null)
				{
					members[i] = basic;
					return basic;
				}
				i++;
			}
			
			if(_maxSize > 0 && members.length >= _maxSize){ return basic; }

			members.push(basic);
			return basic;
		}
		
		public function recycle(type:Class):FlxBasic
		{
			var basic:FlxBasic;
			if(_maxSize > 0)
			{
				return rotatingRecycle(type);
			}else{
				return rollingRecycle(type);
			}
		}
		
		public function rotatingRecycle(type:Class):FlxBasic
		{
			if(members.length < _maxSize)
			{
				return add(new type() as FlxBasic);
			}else{
				if(_recycleMarker >= _maxSize){ _recycleMarker = 0; }
				return members[_recycleMarker++];
			}
		}
		
		public function rollingRecycle(type:Class):FlxBasic
		{
			var basic:FlxBasic = getFirstAvailable(type);

			if(basic != null){
				return basic;
			}else{
				return add(new type() as FlxBasic);
			}
		}
		
		public function remove(basic:FlxBasic,splice:Boolean=false):FlxBasic
		{
			var i:int = members.indexOf(basic);
			var l:int = members.length;
			
			if((i < 0) || (i >= l)){ return null; }

			if(splice)
			{
				members.splice(i,1);
				length--;
			}else{
				members[i] = null;
			}
			
			return basic;
		}
		
		public function replace(oldBasic:FlxBasic, newBasic:FlxBasic):FlxBasic
		{
			var i:int = members.indexOf(oldBasic);
			var l:int = members.length;

			if((i < 0) || (i >= l)){ return null; }

			members[i] = newBasic;
			return newBasic;
		}
		
		public function sort(index:String="y", order:int=ASCENDING):void
		{
			_sortIndex = index;
			_sortOrder = order;
			members.sort(sortHandler);
		}
		
		protected function sortHandler(a:FlxBasic, b:FlxBasic):int
		{
			if(a[_sortIndex] < b[_sortIndex]){
				return _sortOrder;
			}else if(a[_sortIndex] > b[_sortIndex]){
				return -_sortOrder;
			}else{
				return 0;
			}
		}
		
		public function getFirstAvailable(type:Class=null):FlxBasic
		{
			var basic:FlxBasic;
			var i:uint = 0;
			var l:uint = members.length;
			
			while(i < l)
			{
				basic = members[i++] as FlxBasic;
				if(basic == null || basic.exists){ continue; }
				
				if(type == null || basic is type){
					return basic;
				}
			}
			
			return null;
		}
		
		public function getFirstNull():int
		{
			var basic:FlxBasic;
			var i:uint = 0;
			var l:uint = members.length;
			
			while(i < l)
			{
				if(members[i] == null)
					return i;
				else
					i++;
			}
			
			return -1;
		}
		
		public function getFirstExtant():FlxBasic
		{
			var basic:FlxBasic;
			var i:uint = 0;
			var l:uint = members.length;
			
			while(i < l)
			{
				basic = members[i++] as FlxBasic;
				if(basic != null && basic.exists){ return basic; }
			}

			return null;
		}
		
		public function getFirstAlive():FlxBasic
		{
			var basic:FlxBasic;
			var i:uint = 0;
			var l:uint = members.length;
			
			while(i < l)
			{
				basic = members[i++] as FlxBasic;
				if((basic != null) && basic.exists && basic.alive)
					return basic;
			}
			return null;
		}

		public function getFirstDead():FlxBasic
		{
			var basic:FlxBasic;
			var i:uint = 0;
			var l:uint = members.length;

			while(i < l)
			{
				basic = members[i++] as FlxBasic;
				if((basic != null) && !basic.alive)
					return basic;
			}
			return null;
		}

		public function countLiving():int
		{
			var count:int = -1;
			var basic:FlxBasic;
			var i:uint = 0;
			var l:uint = members.length;
			
			while(i < l)
			{
				basic = members[i++] as FlxBasic;
				if(basic != null)
				{
					if(count < 0)
						count = 0;
					if(basic.exists && basic.alive)
						count++;
				}
			}
			return count;
		}
		
		public function countDead():int
		{
			var count:int = -1;
			var basic:FlxBasic;
			var i:uint = 0;
			var l:uint = members.length;

			while(i < l)
			{
				basic = members[i++] as FlxBasic;
				if(basic != null)
				{
					if(count < 0)
						count = 0;
					if(!basic.alive)
						count++;
				}
			}
			return count;
		}
		
		public function getRandom(start:uint=0,range:uint=0):FlxBasic
		{
			if(range == 0){ range = members.length; }
			return FlxG.getRandom(members,start,range) as FlxBasic;
		}
		
		public function clear():void{ members.length = 0; }
	}
}
