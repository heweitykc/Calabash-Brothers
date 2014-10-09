package com.game.team.handler
{
    import com.game.team.control.*;
    import com.game.team.message.*;
    import net.*;

    public class ResTeamClientRefreshHandler extends Handler
    {

        public function ResTeamClientRefreshHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTeamClientRefreshMessage(this.message);
            TeamControl.getInstance().teamClientRefreshBack(_loc_1);
            return;
        }// end function

    }
}
