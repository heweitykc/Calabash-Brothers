package com.game.player.handler
{
    import com.game.player.message.*;
    import net.*;

    public class ResChangePlayerUserToClientHandler extends Handler
    {

        public function ResChangePlayerUserToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChangePlayerUserToClientMessage(this.message);
            return;
        }// end function

    }
}
