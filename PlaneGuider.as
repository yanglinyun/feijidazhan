package  {
	
	
	
	import flash.events.MouseEvent;

	public class PlaneGuider extends Guider {
		
		
		public function PlaneGuider(playing:Function) {
			super(0,0);
			trace(this.getChildByName('btnok'))
			this.getChildByName('btnok').addEventListener(MouseEvent.MOUSE_DOWN,function(){
				trace("点击");
				if (GameItem.stage.contains(that)) {
                    GameItem.stage.removeChild(that);
                }
				GameItem.stage.addChild(new MissleGuider(playing));
			})
		}
	}
	
}
