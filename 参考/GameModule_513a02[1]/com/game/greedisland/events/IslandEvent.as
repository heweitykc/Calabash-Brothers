package com.game.greedisland.events
{
    import flash.events.*;

    public class IslandEvent extends Event
    {
        public var data:Object;
        public static const ISLAND_ELECMENTS_DATA_CHANGE:String = "islandElecmentDataChange";

        public function IslandEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new IslandEvent(type, this.data, bubbles, cancelable);
        }// end function

    }
}
