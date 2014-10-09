package com.game.cloudbuy.events
{
    import flash.events.*;

    public class CloudBuyEvent extends Event
    {
        public var data:Object;
        public static const CLOUD_BUY_INFO_CHANGE:String = "CloudBuyInfoChange";

        public function CloudBuyEvent(param1:String, param2, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new CloudBuyEvent(type, this.data, bubbles, cancelable);
        }// end function

    }
}
