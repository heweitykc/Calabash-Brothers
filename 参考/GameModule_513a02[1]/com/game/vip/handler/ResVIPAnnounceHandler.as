package com.game.vip.handler
{
    import com.game.vip.message.*;
    import net.*;

    public class ResVIPAnnounceHandler extends Handler
    {

        public function ResVIPAnnounceHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResVIPAnnounceMessage(this.message);
            return;
        }// end function

    }
}
