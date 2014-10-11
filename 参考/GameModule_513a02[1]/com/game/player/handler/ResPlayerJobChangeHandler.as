package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerJobChangeHandler extends Handler
    {

        public function ResPlayerJobChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerChangeJobMessage(this.message);
            PlayerControl.getInstance().playerJobChangeHandler(_loc_1);
            return;
        }// end function

    }
}
