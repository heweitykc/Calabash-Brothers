package com.game.player.handler
{
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerNameInfoToClientHandler extends Handler
    {

        public function ResPlayerNameInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerNameInfoToClientMessage(this.message);
            return;
        }// end function

    }
}
