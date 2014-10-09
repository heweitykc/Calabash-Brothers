package com.game.signwage.handler
{
    import com.game.signwage.control.*;
    import com.game.signwage.message.*;
    import net.*;

    public class ResReceiveAwardsHandler extends Handler
    {

        public function ResReceiveAwardsHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResReceiveAwardsMessage(this.message);
            SignWageControl.getInstance().setReceiveBtnDisable(_loc_1.type);
            return;
        }// end function

    }
}
