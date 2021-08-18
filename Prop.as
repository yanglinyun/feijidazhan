package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.*;

	public class Prop extends MoveGameItem implements IMoveItemConflict{
		private var _moveArea:MoveArea;
		private var that:Prop;
        private var type:uint;//1-4
        private var dieTimeOutId:uint;//1-4
        private var prop:MovieClip;
        private var myPlane:MyPlane;
        private var timeOut:uint;

		public function Prop(posX:Number=0, posY:Number=0,moveArea:Object=null, speed:Number=1, width:Number=0, height:Number=0, rotation:Number=0)
		{
            this._moveArea = new MoveArea(
				GameItem.ScreenWidth, 
				MoveGameItem.panel.width-50,
				GameItem.ScreenHeight,
				0
			)
			super(moveArea, posX, posY, speed, width, height, rotation);
            that = this;
			type = Math.ceil(Math.random()*4);
           
            buff();
          
        	this.moveWay = new LineMove(this,[6], [this.speed], [{x:960, y:this._moveArea.yMax + this.height}])
            GameItem.stage.addChild(this);
            
		}

		public function buff(){
            switch(type){
                case 1:// tie
                    this.gotoAndStop(1);
                   
                   
                    break;
                case 2:// jiguang
                    this.gotoAndStop(2);
                  
                   
                    break;
                case 3:// money
                    this.gotoAndStop(3);
                    
                  
                    break;
                case 4:// life
                    this.gotoAndStop(4);
                   
                  
                    break;
            }

             prop = ((this.getChildByName("mc") as MovieClip));
             prop.gotoAndStop(1);
                  
		}

         public function bang(myPlane:MyPlane) {
			this.myPlane = myPlane;
            switch(type){
                case 1:// tie
                   
                    mage();
                    break;
                case 2:// jiguang
                    
                    jiguang();
                    break;
                case 3:// money
                    
                    money();
                    break;
                case 4:// life
                  
                    life();
                    break;
            }
            prop.play()
			dieTimeOutId = setTimeout(function(){
                 prop.stop()
					clearTimeout(dieTimeOutId);
					dieTimeOutId = 0;
					that.dieFreeze();
			}, 500)
          
		}
        
        protected function dieFreeze(evt:Event=null) {
            that.isFreeze = true;
			if(GameItem.stage.contains(that)){
				GameItem.stage.removeChild(that);		
			}
        }

        private function mage(){
            this.myPlane.curEffect = 4;
            GameItem.stage.addChild(this.myPlane.effectArr[4]);
            timeOut = setTimeout(function(){
                   that.myPlane.curEffect = 0;
					clearTimeout(timeOut);
					timeOut = 0;
                    MyPlane.isDoubleScore = 1;
                    if(GameItem.stage.contains(that)){
						GameItem.stage.removeChild(that.myPlane.effectArr[4]);
						
					}
			}, 10000)
        }

        private function jiguang(){
              this.myPlane.curEffect = 3;
              GameItem.stage.addChild(this.myPlane.effectArr[3]);
            timeOut = setTimeout(function(){
                   that.myPlane.curEffect = 0;
					clearTimeout(timeOut);
					timeOut = 0;
                    MyPlane.isDoubleScore = 1;
                    if(GameItem.stage.contains(that)){
						GameItem.stage.removeChild(that.myPlane.effectArr[3]);
						
					}
			}, 10000)
        }

        private function money(){
            // 10s内 击中飞机2倍经验
             MyPlane.isDoubleScore = 2;
             GameItem.stage.addChild(this.myPlane.effectArr[2]);
             this.myPlane.curEffect = 2;
            timeOut = setTimeout(function(){
                    that.myPlane.curEffect = 0;
					clearTimeout(timeOut);
					timeOut = 0;
                    MyPlane.isDoubleScore = 1;
                    if(GameItem.stage.contains(that)){
						GameItem.stage.removeChild(that.myPlane.effectArr[2]);
						
					}
			}, 10000)
        }

        private function life(){
           this.myPlane.curEffect = 1;
           GameItem.stage.addChild(this.myPlane.effectArr[1]);
            timeOut = setTimeout(function(){
                    that.myPlane.curEffect = 0;
					clearTimeout(timeOut);
					timeOut = 0;
                    MyPlane.isDoubleScore = 1;
                    if(GameItem.stage.contains(that)){
						GameItem.stage.removeChild(that.myPlane.effectArr[1]);
						
					}
			}, 10000)
           this.myPlane.addLife(200); 
        }

		public function hit(target:*):Boolean{
			return false;
		};
		public function destory(){};


	}
	
}
