package com.game.signwage.handler
{
    import com.game.signwage.control.*;
    import com.game.signwage.message.*;
    import net.*;

    public class RessignnumToClientHandler extends Handler
    {

        public function RessignnumToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = RessignnumToClientMessage(this.message);
            SignWageControl.getInstance().setSignNumtoClient(_loc_1.signnum);
            return;
        }// end function

    }
}
