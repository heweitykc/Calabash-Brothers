package com.game.bossrank.events
{
    import flash.events.*;

    public class BossDamageEvent extends Event
    {
        public var data:Object;
        public static const BOSS_DAMAGE_DATA_CHANGE:String = "bossDamageDataChange";

        public function BossDamageEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new BossDamageEvent(type, this.data, bubbles, cancelable);
        }// end function

    }
}
