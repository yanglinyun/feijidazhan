package  {
	import flash.text.TextField;

	public class GameEndPanel extends StaticGameItem {
		
		public static var singleInstance:GameEndPanel = null;
		public function GameEndPanel() {
			super(GameItem.ScreenWidth/2 - this.width / 2 + 200,GameItem.ScreenHeight/2 - this.height / 2);
		}

		public static function getInstance():GameEndPanel {
			if(!singleInstance){
				singleInstance = new GameEndPanel();
			}
			singleInstance.init();// 初始化
			return singleInstance;
		}
		

		private function init() {
			// 居中显示
			var score:TextField = TextField(singleInstance.getChildByName("score"));
			score.text = (Panel.scoreCount + "");
			var enemyPlaneCount:TextField = TextField(singleInstance.getChildByName("enemyPlaneCount"));
			enemyPlaneCount.text = (Panel.enemyPlaneCount + "");
			trace(singleInstance);
			GameItem.stage.addChild(singleInstance)
		}
	}
	
}
