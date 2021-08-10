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
		private var background:Background = new Background();
		private var panel:Panel = new Panel(0,0);
		private var myPlaneMoveArea:Object = {x:{max:ScreenWidth,min:panel.width-50,scale:ScreenWidth - panel.width + 50},y:{max:ScreenHight,min:200,scale:ScreenHight-200}};
		private var myPlane:MyPlane = new MyPlane(myPlaneMoveArea,10);
		private var enemyPlaneMoveArea:Object = {x:{max:ScreenWidth,min:panel.width-50,scale:ScreenWidth - panel.width + 50},y:{max:ScreenHight,min:0,scale:ScreenHight}};
		private var myEnemyPlane1:EnemyPlane1 = new EnemyPlane1(enemyPlaneMoveArea,10);
		private var keyBoradController:KeyBoradController;
		 
		public function Main()
		{
			keyBoradController = new KeyBoradController(stage);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(evt:Event):void
		{

			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			// 舞台注册
			//addChild(background);
			//moveItemList.push(background);
			// 左面板注册;
			addChild(panel);
			// 我方飞机注册
			keyBoradController.addKeyUpDown(myPlane);
			addChild(myPlane);
			// 添加敌机
			
			moveItemList.push(myEnemyPlane1);// x = 960 屏幕宽度 防止提前碰边界
			addChild(myEnemyPlane1);
			this.addEventListener(Event.ENTER_FRAME, onEnterframe);
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
				if(!moveItemList[i].isFreeze) {
					moveItemList[i].move();
				}
			}
		}
	}

}