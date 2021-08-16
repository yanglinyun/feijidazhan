package  {
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.*;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.utils.*;
	public class MyPlane extends Plane{

		private var keyObj:Object = {};
		private var keyArr:Array = [];
		private var _moveArea:MoveArea;
		private var _speed:Number = 7;
		private var that:MyPlane;
		private var timeOutId:uint;
		private var fireThrottle:Boolean = false;//1s 一次
		private var fireThrottleTimeId:uint;//1s 一次


		public function MyPlane() {
		
			this._moveArea = new MoveArea(
				GameItem.ScreenWidth, 
				MoveGameItem.panel.width-50,
				GameItem.ScreenHeight,
				200
			)
			super(this._moveArea ,0 ,0 , _speed);
			//bulletTypeArr.push(MyBullet1);
			// 居中显示
			midDisplay();
			
			this.gotoAndStop(1); // 正常状态
			this.totalLife = this.curLife = 800; // 血量
			panel.updateInfo(this.curLife, this.totalLife)

			setInterval(fireThreeBullet, 400, [TwoBullet, ThreeBullet, ThreeBullet]);

			that = this;
		}

		private function fireThreeBullet(bulletComb:Array) {
			var bullet:*;
			var threeBulletArr:Array = [];
			var mustCombArr:Array = [TwoBullet, ThreeBullet, ThreeBullet];
			for(var i:int=0; i<bulletArr.length; i++){
				
				if(mustCombArr.length==0){
					break;// 查询完毕
				}
				if(bulletArr[i].isFreeze && (bulletArr[i] is mustCombArr[0])){
			
					threeBulletArr.push(bulletArr[i]);
					mustCombArr.shift();
				}
			}
			if(mustCombArr.length==0) {
				threeBulletArr[0].born(this.x + this.width / 2, this.y);
				threeBulletArr[1].born(this.x + this.width / 2 - 30, this.y + 20);
				threeBulletArr[2].born(this.x + this.width / 2 + 30, this.y + 20);
				return;
			}
			
			// 新new
			var twoBullet:TwoBullet = new bulletComb[0](this.x + this.width / 2, this.y);
			var leftThreeBullet:ThreeBullet = new bulletComb[1](this.x + this.width / 2 - 30, this.y + 20);
			var rightThreeBullet:ThreeBullet = new bulletComb[2](this.x + this.width / 2 + 30, this.y + 20);
			
			
			bulletArr.push(twoBullet);
			bulletArr.push(leftThreeBullet);
			bulletArr.push(rightThreeBullet);

		
			stage.addChild(twoBullet);
			stage.addChild(leftThreeBullet);
			stage.addChild(rightThreeBullet);
		}

		override protected function fire(bulletType:*) {
			var bullet:*;
			for(var i:int=0; i<bulletArr.length; i++){
				////trace(bulletArr.length);
				if(bulletArr[i].isFreeze && (bulletArr[i] is bulletType)){
					//////trace("========重复利用========");
					bulletArr[i].born(this.x + this.width / 2, this.y);
					//////trace("========重复利用========");
					return;
				}
			}
			// 新new
			bullet = new bulletType(this.x + this.width / 2, this.y);
			
			bulletArr.push(bullet);
			stage.addChild(bullet);
			
		}

		override public function bang(force:Number) {
			
			this.curLife -= force;
			////trace("我飞机当前血量"+this.curLife)
			if(this.curLife<=0){
				// that.gotoAndStop(3);
				// // timeOutId || clearTimeout(timeOutId);
				// timeOutId = setTimeout(function(){
				// 	clearTimeout(timeOutId);
				// 	that.isFreeze = false;
				// 	that.randomBorn();
				// }, 100)
				////trace("游戏结束");
			}else{
				if(keyObj[37]){ // 左移损害
					this.gotoAndStop(6);
				}else if(keyObj[39]){// 右移损害
					this.gotoAndStop(4);
				}else{
					this.gotoAndStop(2);
				}
				
				timeOutId = setTimeout(function(){
					clearTimeout(timeOutId);
					that.gotoAndStop(1);
				}, 500)
			}
			panel.updateInfo(this.curLife, this.totalLife)
		}
		

		public function KeyDownHandler(e:KeyboardEvent)
		{
			keyObj[e.keyCode] = true;

			// 清屏导弹
			if (keyObj[32] && panel.canFireMissle())
			{
				// if(!fireThrottle){
				// 	fireThrottle = true;
				// 	fireThrottleTimeId = setTimeout(function ():void
				// 	{
				// 		clearTimeout(fireThrottleTimeId)
				// 		fireThrottle = false;
				// 	},1000);
				// 	this.fire(MissleBullet);
					
				// }
				this.fire(MissleBullet);
				
				
			}
			
		}

		public function KeyUpHandler(e:KeyboardEvent)
		{
			keyObj[e.keyCode] = false;
	
			
		
		}

		override public function move(isMyPlane:Boolean = false)
		{
			nextPosX = this.x;
			nextPosY = this.y;

		
			
			if (keyObj[37])
			{
				nextPosX -=  this.speed;
				this.gotoAndStop(5);
			}
			if (keyObj[38])
			{
				nextPosY -=  this.speed;	
			}
			if (keyObj[39])
			{
				this.gotoAndStop(3);
				nextPosX +=  this.speed;
			}

			if (keyObj[40])
			{
				nextPosY +=  this.speed;
			}
			// 判断是否越位 更新nextPos
			this.judgeMoveArea()

			// 更新飞机位置
			this.x = nextPosX
			this.y = nextPosY
			
			
		}
		
	}
	
}
