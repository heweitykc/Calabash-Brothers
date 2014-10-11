package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerAttributeChangeHandler extends Handler
    {

        public function ResPlayerAttributeChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerAttributeChangeMessage(this.message);
            PlayerControl.getInstance().playerAttributeChangeHandler(_loc_1);
            return;
        }// end function

    }
}
