package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerPKValueChangeHandler extends Handler
    {

        public function ResPlayerPKValueChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerPkValueChangeMessage(this.message);
            PlayerControl.getInstance().playerPKValueChangeHandler(_loc_1);
            return;
        }// end function

    }
}
