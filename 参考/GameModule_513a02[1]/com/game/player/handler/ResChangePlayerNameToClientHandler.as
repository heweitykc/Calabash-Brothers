package com.game.player.handler
{
    import com.game.player.message.*;
    import net.*;

    public class ResChangePlayerNameToClientHandler extends Handler
    {

        public function ResChangePlayerNameToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChangePlayerNameToClientMessage(this.message);
            return;
        }// end function

    }
}
