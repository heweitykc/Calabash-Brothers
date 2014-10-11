package com.game.player.handler
{
    import com.game.player.message.*;
    import net.*;

    public class ResVipPlayerChangeMapToClientHandler extends Handler
    {

        public function ResVipPlayerChangeMapToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResVipPlayerChangeMapToClientMessage(this.message);
            return;
        }// end function

    }
}
