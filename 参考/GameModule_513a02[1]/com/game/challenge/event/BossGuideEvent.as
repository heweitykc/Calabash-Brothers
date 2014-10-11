package com.game.challenge.event
{
    import flash.events.*;

    public class BossGuideEvent extends Event
    {
        public static const UPDATELOG:String = "updateLog";
        public static const UPDATEBOSS:String = "updateBoss";

        public function BossGuideEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

    }
}
