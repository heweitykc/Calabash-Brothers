package com.game.team.handler
{
    import com.game.team.control.*;
    import com.game.team.message.*;
    import net.*;

    public class ResTeamSetToClientHandler extends Handler
    {

        public function ResTeamSetToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTeamSetToClientMessage(this.message);
            TeamControl.getInstance().teamSetToClientBack(_loc_1);
            return;
        }// end function

    }
}
