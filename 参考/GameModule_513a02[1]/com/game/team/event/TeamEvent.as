package com.game.team.event
{
    import flash.events.*;

    public class TeamEvent extends Event
    {
        public static const TEAM_MEMBER_UPDATE:String = "team_member_update";

        public function TeamEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

    }
}
