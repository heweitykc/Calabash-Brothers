package com.game.login.handler
{
    import com.game.login.control.*;
    import com.game.login.message.*;
    import net.*;

    public class ResHeartHandler extends Handler
    {

        public function ResHeartHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResHeartMessage(this.message);
            RegistControl.getInstance().heartBeatHandler(_loc_1);
            return;
        }// end function

    }
}
