package com.game.historymsg.event
{
    import flash.events.*;

    public class HistorymsgEvent extends Event
    {
        public var data:Object;
        public static const HISTORYMSG_DATA_CHANGE:String = "HISTORYMSG_DATA_CHANGE";

        public function HistorymsgEvent(param1:String, param2 = null)
        {
            super(param1);
            this.data = param2;
            return;
        }// end function

    }
}
