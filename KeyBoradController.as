package 
{
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.EventDispatcher;// 发送事件类c
	
	public class KeyBoradController
	{
		private var stage:Stage;
		private var keyDownArr:Array = [];
		private var keyUpArr:Array = [];
		
		public function KeyBoradController(stage:Stage)
		{
			this.stage = stage
			keyTwo();
		}
		
		public function addKeyDown(obj:MovieClip):void{
			this.keyDownArr.push(obj);
		}
		
		public function addKeyUpDown(obj:MovieClip):void{
			this.keyDownArr.push(obj);
			this.keyUpArr.push(obj);
		}
		
		public function addKeyUp(obj:MovieClip):void{
			this.keyUpArr.push(obj);
		}
		
		private function keyTwo()
		{
			trace("绑定事件");
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDownHandler);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, KeyUpHandler);
		}
		
		private function KeyDownHandler(evt:KeyboardEvent){
			for(var i:int=0; i<this.keyDownArr.length; i++){
				// this.keyDownArr[i].dispatchEvent(new KeyboardEvent("keydown"));
				this.keyDownArr[i].KeyDownHandler(evt);
			}
			
		}
		
		private function KeyUpHandler(evt:KeyboardEvent){
			for(var i:int=0; i<this.keyUpArr.length; i++){
				this.keyDownArr[i].KeyUpHandler(evt);
			}
			
		}
	}

}