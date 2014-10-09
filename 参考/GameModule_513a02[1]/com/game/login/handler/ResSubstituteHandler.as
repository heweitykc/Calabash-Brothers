package com.game.login.handler
{
    import com.game.login.control.*;
    import com.game.login.message.*;
    import net.*;

    public class ResSubstituteHandler extends Handler
    {

        public function ResSubstituteHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSubstituteMessage(this.message);
            RegistControl.getInstance().substituteHandler(_loc_1);
            return;
        }// end function

    }
}
