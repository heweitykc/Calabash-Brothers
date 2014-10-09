package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResRoundChangeJobHandler extends Handler
    {

        public function ResRoundChangeJobHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundChangeJobMessage(this.message);
            PlayerControl.getInstance().playerRoundJobChangeHandler(_loc_1);
            return;
        }// end function

    }
}
