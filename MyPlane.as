package  {
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class MyPlane extends Plane{


		private var keyObj:Object = {};
		
		private var keyArr:Array = [];
		
		
		public function MyPlane(moveArea:Object,speed:Number, panel:Panel) {
			super(moveArea,0,0,speed );
			//bulletTypeArr.push(MyBullet1);
			// 居中显示
			midDisplay(moveArea);
			this.gotoAndStop(1);
			// this.addEventListener(KeyboardEvent.KEY_DOWN, KeyDownHandler);
			// this.addEventListener(KeyboardEvent.KEY_UP, KeyUpHandler);
			this.totalLife = this.curLife = 800;
			panel.updateInfo(this.curLife, this.totalLife)
		}
		private function midDisplay(moveArea:Object){
			//trace(moveArea.y.max, this.height);
			this.x = moveArea.x.min + moveArea.x.scale / 2 - this.width / 2;
			this.y = moveArea.y.max - this.height;
			//trace(this.x, this.y);
			
		}
		override protected function fire() {
			var bullet:TwoBullet;
			for(var i:int=0; i<bulletArr.length; i++){
				if(bulletArr[i].isFreeze){
					trace("========重复利用========");
					bulletArr[i].born(this.x + this.width / 2, this.y);
					trace("========重复利用========");
					return;
				}
			}
			
			bullet = new TwoBullet(this.moveArea, this.x + this.width / 2, this.y, 3);
			bulletArr.push(bullet);
			stage.addChild(bullet);
			trace(stage);
			//trace('fire');
			//trace(bullet.x);
			//trace('================');
		}
		public function KeyDownHandler(e:KeyboardEvent)
		{
			
			keyObj[e.keyCode] = true;

			
		}

		override public function move(isMyPlane:Boolean = false)
		{

			nextPosX = this.x;
			nextPosY = this.y;

			
			if (keyObj[32])
			{
				
				this.fire();
			
			}
			if (keyObj[37])
			{
				trace("left");
				nextPosX-=  this.speed;
				this.gotoAndStop(5);
			}
			if (keyObj[38])
			{
				trace("down");
				nextPosY -=  this.speed;
				
			}
			if (keyObj[39])
			{
				trace("right");
				this.gotoAndStop(3);
				nextPosX +=  this.speed;
			}

			if (keyObj[40])
			{
				trace("up");
				nextPosY +=  this.speed;
			}
		
			this.judgeMoveArea()

			
			this.x = nextPosX
			this.y = nextPosY
			
		}

		public function KeyUpHandler(e:KeyboardEvent)
		{
			keyObj[e.keyCode] = false;
		
		}

	}
	
}
