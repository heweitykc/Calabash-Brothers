package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResReviveSuccessHandler extends Handler
    {

        public function ResReviveSuccessHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResReviveSuccessMessage(this.message);
            PlayerControl.getInstance().reviveSuccessHandler(_loc_1);
            return;
        }// end function

    }
}
