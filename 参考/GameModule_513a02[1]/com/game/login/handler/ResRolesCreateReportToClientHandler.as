package com.game.login.handler
{
    import com.game.login.message.*;
    import net.*;

    public class ResRolesCreateReportToClientHandler extends Handler
    {

        public function ResRolesCreateReportToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRolesCreateReportToClientMessage(this.message);
            return;
        }// end function

    }
}
