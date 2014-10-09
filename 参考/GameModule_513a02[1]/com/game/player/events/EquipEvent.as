package com.game.player.events
{
    import flash.events.*;

    public class EquipEvent extends Event
    {
        public var data:Object;
        public static const WEAR:String = "wear";
        public static const TAKE_OFF:String = "takeoff";
        public static const EQUIPSTRENTH:String = "equipstrenth";

        public function EquipEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new EquipEvent(type, this.data, bubbles, cancelable);
        }// end function

    }
}
