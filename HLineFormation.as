package{
    class HLineFormation extends Formation{

        public function HLineFormation(artRes:*) {
           super(artRes);
		   generate(artRes);
        }

        override public function generate(artRes:*) {
            for(var i:int=1; i<=5; i++){
                // // 添加敌机
                var enemyPlane:* = new artRes(baseX + stageWidth/6 * i, 0);
                Level.moveItemList.push(enemyPlane);// x = 960 屏幕宽度 防止提前碰边界
                GameItem.stage.addChild(enemyPlane);
            }
        }
    }
}