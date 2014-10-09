package com.game.player.handler
{
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerCheckOnlineHandler extends Handler
    {

        public function ResPlayerCheckOnlineHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerCheckOnlineMessage(this.message);
            return;
        }// end function

    }
}
