package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerAvatarHandler extends Handler
    {

        public function ResPlayerAvatarHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerAvatarMessage(this.message);
            PlayerControl.getInstance().playerAvatarHandler(_loc_1);
            return;
        }// end function

    }
}
