package com.game.stalls.events
{
    import flash.events.*;

    public class StallsEvent extends Event
    {
        public var data:Object;
        public static const SELECTED:String = "selected";
        public static const SELECTEDGOOD:String = "selectgood";
        public static const INFO:String = "info";
        public static const BUY:String = "buy";

        public function StallsEvent(param1:String, param2, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new StallsEvent(type, this.data, bubbles, cancelable);
        }// end function

    }
}
