package  {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip
	
	public class Main extends Sprite {
		
		public static const ScreenWidth:int = 550;
		public static const ScreenHight:int = 400;
		
		private var background =  new Background(0,0);
		public function Main() {
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(evt:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addChild(background);
			this.addEventListener(Event.ENTER_FRAME, onEnterframe);
		}
		
		private function onEnterframe(evt:Event):void
		{
			
		}
	}
	
}
