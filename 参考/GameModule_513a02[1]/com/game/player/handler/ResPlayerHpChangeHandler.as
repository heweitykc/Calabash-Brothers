package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerHpChangeHandler extends Handler
    {

        public function ResPlayerHpChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerHpChangeMessage(this.message);
            PlayerControl.getInstance().playerHpChangeHandler(_loc_1);
            return;
        }// end function

    }
}
