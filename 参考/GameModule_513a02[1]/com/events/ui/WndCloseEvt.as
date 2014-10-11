package com.events.ui
{
    import flash.events.*;

    public class WndCloseEvt extends Event
    {
        public var wnd:String;
        public static const CLOSE:String = "Wnd_Close_Close";

        public function WndCloseEvt(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
        {
            this.wnd = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new WndCloseEvt(type, this.wnd, bubbles, cancelable);
        }// end function

    }
}
