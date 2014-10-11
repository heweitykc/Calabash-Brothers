package com.game.player.handler
{
    import com.game.player.message.*;
    import net.*;

    public class ResJumpMaxSpeedHandler extends Handler
    {

        public function ResJumpMaxSpeedHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResJumpMaxSpeedMessage(this.message);
            return;
        }// end function

    }
}
