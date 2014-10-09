package com.events.ui
{
    import flash.events.*;

    public class MagicBookEvent extends Event
    {
        public var data:Object;
        public static const UPDATEINFO:String = "updateInfo";
        public static const ATTRINFO_CHANGE:String = "attrInfoChange";
        public static const EXP_CHANGE:String = "expChange";
        public static const USEITEM_CHANGE:String = "useitemChange";
        public static const SKILL_CHANGE:String = "skillChange";
        public static const LEVEL_UP:String = "levelup";
        public static const UPDATE_OTHER_INFO:String = "updateOtherInfo";

        public function MagicBookEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new MagicBookEvent(type, this.data, bubbles, cancelable);
        }// end function

    }
}
