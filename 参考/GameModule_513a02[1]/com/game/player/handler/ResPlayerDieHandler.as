package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerDieHandler extends Handler
    {

        public function ResPlayerDieHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerDieMessage(this.message);
            PlayerControl.getInstance().playerDieHandler(_loc_1);
            return;
        }// end function

    }
}
