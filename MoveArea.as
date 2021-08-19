package {

    public class MoveArea {
        public var xMax:Number;
        public var xMin:Number;
        public var yMax:Number;
        public var yMin:Number;

        public function MoveArea(xMax, xMin, yMax, yMin) {
            this.xMax = xMax;
            this.xMin = xMin;
            this.yMax = yMax;
            this.yMin = yMin;

        }

        public function get xScale():Number {
            return this.xMax - this.xMin;
        }

        public function get yScale():Number {
            return this.yMax - this.yMin;
        }

    }

}
