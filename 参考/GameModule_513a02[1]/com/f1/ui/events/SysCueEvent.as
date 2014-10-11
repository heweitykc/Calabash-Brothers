package com.f1.ui.events
{
    import flash.events.*;

    public class SysCueEvent extends Event
    {
        public var data:String;
        public static const LINK:String = "sys_link";

        public function SysCueEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new SysCueEvent(type, this.data, bubbles, cancelable);
        }// end function

    }
}
