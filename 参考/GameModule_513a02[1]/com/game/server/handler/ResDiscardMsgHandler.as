package com.game.server.handler
{
    import com.game.server.control.*;
    import com.game.server.message.*;
    import net.*;

    public class ResDiscardMsgHandler extends Handler
    {

        public function ResDiscardMsgHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResDiscardMsgMessage(this.message);
            ServerControl.getInstance().discardHandler(_loc_1);
            return;
        }// end function

    }
}
