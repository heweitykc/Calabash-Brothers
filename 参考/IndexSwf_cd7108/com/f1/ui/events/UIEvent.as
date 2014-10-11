package com.f1.ui.events
{
    import flash.events.*;

    public class UIEvent extends Event
    {
        public static const RES_LOAD_COMPLETE:String = "UIEvent_RES_LOAD_COMPLETE";
        public static const RESIZE:String = "UIEvent_RESIZE";
        public static const BOX_LAYOUT_COMPLETE:String = "UIEvent_BOX_LAYOUT_COMPLETE";

        public function UIEvent(param1:String)
        {
            super(param1);
            return;
        }// end function

    }
}
