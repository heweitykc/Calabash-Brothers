package com.f1.vmc
{
    import flash.events.*;

    public class VMCEvent extends Event
    {
        public var obj:Object;
        public static const ACT_EFECT:String = "VMCEvent_ACT_EFECT";
        public static const ACT_RELEASE:String = "VMCEvent_ACT_RELEASE";
        public static const ACT_COMPLETE:String = "VMCEvent_ACT_COMPLETE";

        public function VMCEvent(param1:String, param2 = null)
        {
            super(param1);
            this.obj = param2;
            return;
        }// end function

    }
}
