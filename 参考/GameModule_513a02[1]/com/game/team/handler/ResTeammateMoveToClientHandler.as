package com.game.team.handler
{
    import com.game.team.control.*;
    import com.game.team.message.*;
    import net.*;

    public class ResTeammateMoveToClientHandler extends Handler
    {

        public function ResTeammateMoveToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTeammateMoveToClientMessage(this.message);
            TeamControl.getInstance().teammateMoveToClientBack(_loc_1);
            return;
        }// end function

    }
}
