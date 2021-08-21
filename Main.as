package 
{
	import flash.events.KeyboardEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip;

	public class Main extends Sprite
	{
		private var background:Background;
		private var panel:Panel;
		private var myPlane:MyPlane;
		private var level:Level;
		private var keyBoradController:KeyBoradController;
		// 飞机引导
		private var planeGuider:PlaneGuider;
		private var fp:FPSShow;

		public function Main()
		{
			fp = new FPSShow();
			GameItem.stage = stage;
			GameItem.ScreenHeight = stage.stageHeight;
			GameItem.ScreenWidth = stage.stageWidth;

			panel = new Panel(0,0);
			MoveGameItem.panel = panel;

			keyBoradController = new KeyBoradController();
			GameItem.keyBoradController = keyBoradController;

			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			// 背景注册
			background = new Background();
			MoveGameItem.background = background;
			addChild(background);
			Level.moveItemList.push(background);
			// 左面板注册;
			addChild(panel);
			panel.name = "panel";
			// guider引导动画开始
			planeGuider = new PlaneGuider(playing);
			GameItem.stage.addChild(planeGuider);
		}

		function playing()
		{
			// 我方飞机注册
			myPlane = new MyPlane();
			keyBoradController.addKeyUpDown(myPlane);
			GameItem.stage.addChild(myPlane);
			Level.moveItemList.push(myPlane);
			// 加载关卡;
			level = new Level();
			this.addEventListener(Event.ENTER_FRAME, onEnterframe);
		}

		private function onEnterframe(evt:Event):void
		{
			updateMoveItems();
		}

		private function myPlaneHit():void
		{
			// 自己撞敌机或道具
			for (var moveItemIndex:Number = 0; moveItemIndex < Level.moveItemList.length; moveItemIndex++)
			{
				var enemyPlaneOrProp:* = Level.moveItemList[moveItemIndex];
				if ((enemyPlaneOrProp is EnemyPlane && enemyPlaneOrProp.curLife > 0) || enemyPlaneOrProp is Prop)
				{
					if (myPlane.hit(enemyPlaneOrProp))
					{
						break;
					}
				}
			}
		}

		private function useMissle()
		{
			if (Panel.useMissle)
			{// 导弹清屏-10点
				for (var j:Number = 0; j < Level.moveItemList.length; j++)
				{
					var enemyPlane:* = Level.moveItemList[j];
					if (enemyPlane is EnemyPlane && enemyPlane.curLife > 0)
					{
						enemyPlane.bang(10);
					}
				}
				//-10点;
			}
			Panel.useMissle = false;
		}
		
		private function useJiGuang()
		{
			// 我的激光清线
			var allEnemyPlane:Array = Level.getAllEnemyPlane();
			if (myPlane.curEffect[3] > 0)
			{
				for (var enemyPlaneIndex:Number = 0; enemyPlaneIndex < allEnemyPlane.length; enemyPlaneIndex++)
				{
					var jiGuangEnemyPlane:* = allEnemyPlane[enemyPlaneIndex];
					if (jiGuangEnemyPlane.y <= myPlane.y && (jiGuangEnemyPlane.x >= myPlane.x && jiGuangEnemyPlane.x <= myPlane.x + myPlane.width))
					{
					
						// 由于激光是持续照射所以每帧伤害很小
						jiGuangEnemyPlane.bang(1);
					}
				}
			}
		}

		private function myBulletHitEnemyPlane(bullet:Bullet)
		{
			//==========我子弹打到敌机==============================//
			var allEnemyPlane:Array = Level.getAllEnemyPlane();
			if (myPlane.curEffect[3] == 0)
			{
				for (var enemyPlaneIndex:Number = 0; enemyPlaneIndex < allEnemyPlane.length; enemyPlaneIndex++)
				{
					var beHitedEnemyPlane:* = allEnemyPlane[enemyPlaneIndex];
					if (bullet.hit(beHitedEnemyPlane))
					{
						
						break;
					}
				}
			}
		}
		
		private function bulletHit(bullet:Bullet, itemIndex:int){
			if (!bullet.isFreeze && !(bullet is MissleBullet)) {
				//子弹移动
				bullet.move(); 
				//==========使用导弹===========//
				useMissle();
				if (Level.moveItemList[itemIndex] is EnemyPlane && myPlane.curLife > 0) {
					//==========敌机子弹打到我==============================//
				    bullet.hit(myPlane);
				
				} else if (Level.moveItemList[itemIndex] is MyPlane) {
					//==========我的激光清线==============================//
					useJiGuang();
				    //==========我子弹打到敌机==============================//
				    myBulletHitEnemyPlane(bullet)
				}
			}	
		}

		private function updateMoveItems():void
		{
			// 更新运动物件
			if (Level.isGameOver)
			{
				this.removeEventListener(Event.ENTER_FRAME, onEnterframe);
				return;
			}
			for (var i:int = 0; i < Level.moveItemList.length; i++)
			{
				if (! Level.moveItemList[i].isFreeze)
				{
					// 物件移动
					Level.moveItemList[i].move();
					if (Level.moveItemList[i] is Plane)
					{
						// 自己撞敌机或道具
						myPlaneHit();
						// 检测自己子弹
						Level.moveItemList[i].bulletArr.forEach(function(bullet:Bullet, index:int, arr:Array) {
							// bullet为普通 而非 导弹
						    bulletHit(bullet,i);
						});
					}
				}
			}
		}
	}

}