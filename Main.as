package 
{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip;
	public class Main extends Sprite
	{

		public static const ScreenWidth:int = 960;
		public static const ScreenHight:int = 560;
		private var moveItemList:Array = [];
		private var background:Background = new Background(0,0);
		public function Main()
		{

			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// 舞台注册
			addChild(background);
			moveItemList.push(new LineMove(background,[2], [1], [{x:0, y:-1200}]));
			// 左面板注册
			
			
			this.addEventListener(Event.ENTER_FRAME, onEnterframe);
		}

		private function onEnterframe(evt:Event):void
		{
			
		}
		
		private function updateMoveItems():void
		{
			// 更新运动物件
			for (var i:int=0; i<moveItemList.length; i++)
			{
				moveItemList[i].update();
			}
		}
	}

}