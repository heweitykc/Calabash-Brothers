package com.f1.ui.events
{
    import flash.events.*;

    public class BoxEvent extends Event
    {
        public var showOrHide:int;
        public static const SHOW_HIDE:String = "box_show_hide";
        public static const SHOW_COMPLETE:String = "show_complete";
        public static const HIDE_COMPLETE:String = "hide_complete";

        public function BoxEvent(param1:String, param2:int = 0)
        {
            this.showOrHide = param2;
            super(param1);
            return;
        }// end function

        override public function clone() : Event
        {
            return new BoxEvent(type, this.showOrHide);
        }// end function

    }
}
