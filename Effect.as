package {
    import flash.events.Event;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.utils.*;

    public class Effect extends StaticGameItem {


        public function Effect(posX:Number, posY:Number, width:Number = 0, height:Number = 0, rotation:Number = 0) {
            super(posX, posY, width, height, rotation);
            //this.addEventListener("PlaneLifeChange", updateInfo);			
        }

        public function update(posX:Number, posY:Number) {
            this.x = posX;
            this.y = posY;
        }


    }

}
