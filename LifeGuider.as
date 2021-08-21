
package  {
	
	
	import flash.events.MouseEvent;
	
	public class LifeGuider extends Guider {
		
		
		public function LifeGuider(playing:Function) {
			
			super(0,0);
			this.getChildByName('btnok').addEventListener(MouseEvent.MOUSE_DOWN,function(){
				rc(that)
				playing();
				
			})
		}
	}
	
}

