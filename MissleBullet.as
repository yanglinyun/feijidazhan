package {

    import flash.display.MovieClip;

    import flash.events.Event;

    public class MissleBullet extends MyBullet {


        public function MissleBullet(posX:Number = 0, posY:Number = 0) {
            super(null, posX, posY, 0);
            this.moveWay = new StaticMove(this)
        }
    }

}
