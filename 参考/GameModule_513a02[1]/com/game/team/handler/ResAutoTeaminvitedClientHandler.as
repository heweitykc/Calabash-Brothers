package com.game.team.handler
{
    import com.game.team.control.*;
    import com.game.team.message.*;
    import net.*;

    public class ResAutoTeaminvitedClientHandler extends Handler
    {

        public function ResAutoTeaminvitedClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAutoTeaminvitedClientMessage(this.message);
            TeamControl.getInstance().autoTeamInvitedClientBack(_loc_1);
            return;
        }// end function

    }
}
