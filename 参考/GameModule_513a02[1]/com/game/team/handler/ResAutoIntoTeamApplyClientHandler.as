package com.game.team.handler
{
    import com.game.team.control.*;
    import com.game.team.message.*;
    import net.*;

    public class ResAutoIntoTeamApplyClientHandler extends Handler
    {

        public function ResAutoIntoTeamApplyClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAutoIntoTeamApplyClientMessage(this.message);
            TeamControl.getInstance().autoIntoTeamApplyClientBack(_loc_1);
            return;
        }// end function

    }
}
