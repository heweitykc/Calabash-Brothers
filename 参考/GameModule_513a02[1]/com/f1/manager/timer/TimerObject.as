package com.f1.manager.timer
{

    public class TimerObject extends Object
    {
        public var key:String;
        public var delayPer:uint;
        public var repeatCount:uint;
        public var timerHandler:Function;
        public var completeHandler:Function;
        public var startTime:uint;

        public function TimerObject(param1:String, param2:uint, param3:uint, param4:Function, param5:Function)
        {
            this.key = param1;
            this.delayPer = param2;
            this.repeatCount = param3;
            this.timerHandler = param4;
            this.completeHandler = param5;
            return;
        }// end function

        public function finilize() : void
        {
            this.timerHandler = null;
            this.completeHandler = null;
            return;
        }// end function

    }
}
