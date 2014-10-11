package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResChangeGuildHandler extends Handler
    {

        public function ResChangeGuildHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerGuildChangeMessage(this.message);
            PlayerControl.getInstance().playerGuildChangeHandler(_loc_1);
            return;
        }// end function

    }
}
