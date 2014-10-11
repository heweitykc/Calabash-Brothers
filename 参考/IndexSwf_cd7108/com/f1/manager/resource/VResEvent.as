package com.f1.manager.resource
{
    import flash.events.*;

    public class VResEvent extends ProgressEvent
    {
        public var url:String;
        public static const NOTIFY_LOAD_NEXT:String = "NOTIFY_LOAD_NEXT";
        public static const NOTIFY_LOAD_FAIL:String = "NOTIFY_LOAD_FAIL";
        public static const NOTIFY_LOAD_ONE_COMPLETE:String = "NOTIFY_LOAD_ONE_COMPLETE";

        public function VResEvent(param1:String)
        {
            super(param1);
            return;
        }// end function

    }
}
