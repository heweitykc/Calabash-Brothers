package com.game.supervip.event
{
    import flash.events.*;

    public class SupervipEvent extends Event
    {
        public var data:Object;
        public static const SUPERVIP_DATA_CHANGE:String = "SUPERVIP_DATA_CHANGE";

        public function SupervipEvent(param1:String, param2 = null)
        {
            super(param1);
            this.data = param2;
            return;
        }// end function

    }
}
