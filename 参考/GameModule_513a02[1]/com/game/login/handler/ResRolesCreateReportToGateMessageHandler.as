package com.game.login.handler
{
    import com.game.login.control.*;
    import com.game.login.message.*;
    import net.*;

    public class ResRolesCreateReportToGateMessageHandler extends Handler
    {

        public function ResRolesCreateReportToGateMessageHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRolesCreateReportToGateMessage(this.message);
            RegistControl.getInstance().createRoleSuccessHandler(_loc_1);
            return;
        }// end function

    }
}
