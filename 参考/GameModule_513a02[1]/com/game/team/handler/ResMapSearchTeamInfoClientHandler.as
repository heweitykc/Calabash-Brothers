package com.game.team.handler
{
    import com.game.team.control.*;
    import com.game.team.message.*;
    import net.*;

    public class ResMapSearchTeamInfoClientHandler extends Handler
    {

        public function ResMapSearchTeamInfoClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMapSearchTeamInfoClientMessage(this.message);
            TeamControl.getInstance().mapSearchTeamTeamInfoClientBack(_loc_1);
            return;
        }// end function

    }
}
