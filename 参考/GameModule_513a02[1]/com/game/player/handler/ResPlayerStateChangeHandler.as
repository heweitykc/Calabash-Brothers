package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerStateChangeHandler extends Handler
    {

        public function ResPlayerStateChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerStateChangeMessage(this.message);
            PlayerControl.getInstance().playerStateChangeHandler(_loc_1);
            return;
        }// end function

    }
}
