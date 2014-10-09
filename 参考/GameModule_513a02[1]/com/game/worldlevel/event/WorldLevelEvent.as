package com.game.worldlevel.event
{
    import flash.events.*;

    public class WorldLevelEvent extends Event
    {
        public var data:Object;
        public static const WORLD_LEVEL_DATA_CHANGE:String = "WORLD_LEVEL_DATA_CHANGE";
        public static const WORLD_LEVEL_DETAIL_CHANGE:String = "WORLD_LEVEL_DETAIL_CHANGE";

        public function WorldLevelEvent(param1:String, param2 = null)
        {
            super(param1);
            this.data = param2;
            return;
        }// end function

    }
}
