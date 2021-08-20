package 
{


	import flash.events.MouseEvent;

	public class MissleGuider extends Guider
	{


		public function MissleGuider(playing:Function)
		{
			super(0,0);
			this.getChildByName('btnok').addEventListener(MouseEvent.MOUSE_DOWN,function(){
				if (GameItem.stage.contains(that)) {
                    GameItem.stage.removeChild(that);
                }
				GameItem.stage.addChild(new LifeGuider(playing));
			})
		}
	}

}