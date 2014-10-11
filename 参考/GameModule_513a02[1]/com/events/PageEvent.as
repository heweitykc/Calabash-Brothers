package com.events
{
    import com.model.vo.*;
    import flash.events.*;

    public class PageEvent extends Event
    {
        public var data:PageCountInfo;
        public static const PAGE_CHANGE:String = "page_change";

        public function PageEvent(param1:String, param2:PageCountInfo, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

    }
}
