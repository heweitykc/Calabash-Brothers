package com.game.team.handler
{
    import com.game.team.control.*;
    import com.game.team.message.*;
    import net.*;

    public class ResTeamExteriorClientHandler extends Handler
    {

        public function ResTeamExteriorClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTeamExteriorClientMessage(this.message);
            TeamControl.getInstance().teamExteriorClientBack(_loc_1);
            return;
        }// end function

    }
}
