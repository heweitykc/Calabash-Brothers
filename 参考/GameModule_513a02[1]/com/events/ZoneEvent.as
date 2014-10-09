package com.events
{
    import flash.events.*;

    public class ZoneEvent extends Event
    {
        public var obj:Object;
        public static const ZONE_INFO_UPDATE:String = "zone_info_update";
        public static const ZONE_CD_UPDATE:String = "zone_cd_update";

        public function ZoneEvent(param1:String, param2 = null)
        {
            this.obj = param2;
            super(param1);
            return;
        }// end function

    }
}
