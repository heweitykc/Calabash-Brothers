package com.game.protect.handler
{
    import com.game.protect.control.*;
    import com.game.protect.message.*;
    import net.*;

    public class ResPointToClientHandler extends Handler
    {

        public function ResPointToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            ProtectControl.getInstance().resPointToClient(message as ResPointToClientMessage);
            return;
        }// end function

    }
}
