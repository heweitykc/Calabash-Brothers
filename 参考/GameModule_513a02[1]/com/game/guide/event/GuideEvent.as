package com.game.guide.event
{
    import flash.events.*;

    public class GuideEvent extends Event
    {
        public var data:Object;
        public static var GUIDE_ACTIVE:String = "guide_active";
        public static var GUIDE_ACTIVE_CONFIG_COMPLETE:String = "guide_active_config_complete";

        public function GuideEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

    }
}
