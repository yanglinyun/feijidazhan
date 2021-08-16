package 
{
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	
	public class KeyBoradController
	{
		private var stage:Stage = GameItem.stage;
		private var keyDownArr:Array = [];
		private var keyUpArr:Array = [];
		
		public function KeyBoradController()
		{
			//trace(stage.stageWidth);
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
		
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDownHandler);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, KeyUpHandler);
		}
		
		private function KeyDownHandler(evt:KeyboardEvent){
		
			for(var i:int=0; i<this.keyDownArr.length; i++){
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