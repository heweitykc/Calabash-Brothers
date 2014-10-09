package com.game.server.handler
{
    import com.game.server.control.*;
    import com.game.server.message.*;
    import net.*;

    public class ResCloseServerHandler extends Handler
    {

        public function ResCloseServerHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCloseServerMessage(this.message);
            ServerControl.getInstance().resCloseServerBack(_loc_1);
            return;
        }// end function

    }
}
