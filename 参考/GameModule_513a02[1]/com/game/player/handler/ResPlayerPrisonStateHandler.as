package com.game.player.handler
{
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerPrisonStateHandler extends Handler
    {

        public function ResPlayerPrisonStateHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerPrisonStateMessage(this.message);
            return;
        }// end function

    }
}
