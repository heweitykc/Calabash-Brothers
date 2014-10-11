package com.game.map.event
{
    import flash.events.*;

    public class MapEvent extends Event
    {
        public static const MAP_CHANGE:String = "map_change";
        public static const MAP_CHANGE_COMPLETE:String = "map_change_complete";

        public function MapEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

    }
}
