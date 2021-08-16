package 
{
	import flash.events.KeyboardEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip;
	public class Main extends Sprite
	{
		private var ScreenWidth:Number;
		private var ScreenHight:Number;
		private var moveItemList:Array = [];
		private var background:Background;
		private var panel:Panel =  new Panel(0,0);
		private var myPlaneMoveArea:Object = {x:{max:ScreenWidth,min:panel.width-50,scale:ScreenWidth - panel.width + 50},y:{max:ScreenHight,min:200,scale:ScreenHight-200}};
		private var myPlane:MyPlane;
		private var enemyPlane1:EnemyPlane2;
		private var keyBoradController:KeyBoradController;

		private var fp:FPSShow;

		public function Main()
		{
			ScreenWidth = stage.stageWidth;
			ScreenHight = stage.stageHeight;
			fp = new FPSShow();
			GameItem.stage = stage;
			MoveGameItem.panel = panel;
			GameItem.ScreenHeight = stage.stageHeight;
			GameItem.ScreenWidth = stage.stageWidth;
			keyBoradController = new KeyBoradController();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			// 背景注册
			background = new Background()
			addChild(background);
			moveItemList.push(background);
			// 左面板注册;
			addChild(panel);
			panel.name = "panel"			
			myPlane = new MyPlane();
			// 我方飞机注册
			keyBoradController.addKeyUpDown(myPlane);
			addChild(myPlane);
			moveItemList.push(myPlane);
			// // 添加敌机
			enemyPlane1 = new EnemyPlane2();
			moveItemList.push(enemyPlane1);// x = 960 屏幕宽度 防止提前碰边界
			addChild(enemyPlane1);
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
					if(moveItemList[i] is Plane){
						////trace("===status=======")
						moveItemList[i].bulletArr.forEach(function(item:Bullet, index:int, arr:Array){
							////trace(item.isFreeze);
							if(!item.isFreeze && !(item is MissleBullet) ){
								item.move();
								if(Panel.useMissle){ // 导弹清屏-10点
									enemyPlane1.bang(10);
									Panel.useMissle = false;
								}
								if(moveItemList[i] is EnemyPlane && myPlane.curLife >0){
									item.hit(myPlane);
								}else{

									if(enemyPlane1.curLife >0){
										item.hit(enemyPlane1);
									}
									
								}
							}
						})
					}	
				
				}
			}
		}
	}

}