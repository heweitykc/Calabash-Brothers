package com.f1.vmc
{
    import com.f1.structs.*;

    public class PoseInfo extends BaseInfo
    {
        public var inters:Array;
        public var poses:Array;
        public var offsets:Array;
        public var sound:String;
        public var delay:Number = 0;
        private var _effectTime:Number = 0;
        private var _lastTime:Number = 0;
        public var blendMode:String;
        public var scale:Number;
        public var layout:Boolean;
        public var effectFrame:uint;
        public var offsetY:Number = 0;
        public var offsetX:Number = 0;
        public var rotate360:Boolean;
        public var repeat:Boolean;
        public var poseIndex:uint;
        private var _releaseTime:Number = 0;
        private var _releaseFrame:uint;
        private var _horseY:Number = 0;

        public function PoseInfo()
        {
            return;
        }// end function

        public function get releaseFrame() : uint
        {
            return this._releaseFrame;
        }// end function

        public function set releaseFrame(param1:uint) : void
        {
            this._releaseFrame = param1;
            return;
        }// end function

        public function get releaseTime() : Number
        {
            return this._releaseTime;
        }// end function

        public function set releaseTime(param1:Number) : void
        {
            this._releaseTime = param1;
            return;
        }// end function

        public function get lastTime() : Number
        {
            return this._lastTime;
        }// end function

        public function set lastTime(param1:Number) : void
        {
            this._lastTime = param1;
            return;
        }// end function

        public function get effectTime() : Number
        {
            return this._effectTime;
        }// end function

        public function set effectTime(param1:Number) : void
        {
            this._effectTime = param1;
            return;
        }// end function

        public function get horseY() : Number
        {
            return this._horseY;
        }// end function

        public function set horseY(param1:Number) : void
        {
            this._horseY = param1;
            return;
        }// end function

    }
}
