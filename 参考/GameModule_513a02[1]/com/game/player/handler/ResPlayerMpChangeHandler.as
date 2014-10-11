package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerMpChangeHandler extends Handler
    {

        public function ResPlayerMpChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerMpChangeMessage(this.message);
            PlayerControl.getInstance().playerMpChangeHandler(_loc_1);
            return;
        }// end function

    }
}
