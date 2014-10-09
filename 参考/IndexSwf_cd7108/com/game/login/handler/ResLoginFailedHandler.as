package com.game.login.handler
{
    import com.game.login.control.*;
    import com.game.login.message.*;
    import net.*;

    public class ResLoginFailedHandler extends Handler
    {

        public function ResLoginFailedHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResLoginFailedMessage(this.message);
            RegistControl.getInstance().loginFailHandler(_loc_1);
            return;
        }// end function

    }
}
