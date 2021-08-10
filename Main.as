package 
{
	import flash.events.KeyboardEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip;
	public class Main extends Sprite
	{

		public static const ScreenWidth:int = 960;
		public static const ScreenHight:int = 560;
		private var moveItemList:Array = [];
		private var background:Background = new Background(0,0);
		private var panel:Panel = new Panel(0,0);
		private var moveArea:Object = {x:{max: ScreenWidth,min: panel.width,scale: ScreenWidth - panel.width}, y:{max: ScreenHight, min:0, scale: ScreenHight}};
		private var myPlane:MyPlane = new MyPlane(moveArea);
		
		
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
			addChild(panel);
			// 我方飞机注册
			
			addChild(myPlane)
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);
			this.stage.addEventListener(KeyboardEvent.KEY_UP,keyUpFunction);
			this.addEventListener(Event.ENTER_FRAME, onEnterframe);
		}
		private function keyUpFunction(evt:KeyboardEvent):void{
			myPlane.gotoAndStop(1);
		}
		private function keyDownFunction(evt:KeyboardEvent):void{
			
			
			switch(evt.keyCode){
				case 37: // left
					myPlane.x -= 5;
					myPlane.gotoAndStop(5);
					break;
				case 38: // up
					myPlane.y -= 5;
					break;
				case 39: // right
					myPlane.x += 5;
					myPlane.gotoAndStop(3);
					break;
				case 40: // down
					myPlane.y += 5;
					break;
				case 32: // space
					//this.fire();
					break;
			}
		} 
		private function onEnterframe(evt:Event):void
		{
			updateMoveItems();
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