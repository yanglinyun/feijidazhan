package  {
	import flash.text.TextField;

	public class GameEndPanel extends StaticGameItem {
		
		
		public function GameEndPanel() {
			// 居中显示
			super(GameItem.ScreenWidth/2 - this.width / 2 + 200,GameItem.ScreenHeight/2 - this.height / 2);
			if(Level.stageHasBoss()){
				EnemyPlane6.gameOver();
			}
			var score:TextField = TextField(getChildByName("score"));
			score.text = (Panel.scoreCount + "");
			var enemyPlaneCount:TextField = TextField(getChildByName("enemyPlaneCount"));
			enemyPlaneCount.text = (Panel.enemyPlaneCount + "");
			GameItem.stage.addChild(this)
		}
	}
	
}
