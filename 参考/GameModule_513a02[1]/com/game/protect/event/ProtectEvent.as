package com.game.protect.event
{
    import flash.events.*;

    public class ProtectEvent extends Event
    {
        public var data:Object;
        public static const PROTECT_DATA_CHANGE:String = "PROTECT_DATA_CHANGE";
        public static const PASSWORD_COMPARE_RESULT:String = "PASSWORD_COMPARE_RESULT";
        public static const MODIFY_PASSWORD_OK:String = "MODIFY_PASSWORD_OK";
        public static const HIGH_LOCK_UPDE:String = "HIGH_LOCK_UPDE";

        public function ProtectEvent(param1:String, param2 = null)
        {
            super(param1);
            this.data = param2;
            return;
        }// end function

    }
}
