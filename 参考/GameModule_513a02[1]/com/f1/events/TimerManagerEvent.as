package com.f1.events
{
    import flash.events.*;

    public class TimerManagerEvent extends TimerEvent
    {
        public var pastCount:uint;
        public var repeatCount:uint;
        public var delay:uint;

        public function TimerManagerEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

    }
}
