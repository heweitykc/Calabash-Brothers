package com.game.team.handler
{
    import com.game.team.control.*;
    import com.game.team.message.*;
    import net.*;

    public class ResInviteClientHandler extends Handler
    {

        public function ResInviteClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResInviteClientMessage(this.message);
            TeamControl.getInstance().InviteClientBack(_loc_1);
            return;
        }// end function

    }
}
