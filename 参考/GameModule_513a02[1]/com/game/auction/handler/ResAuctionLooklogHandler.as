package com.game.auction.handler
{
    import com.game.auction.control.*;
    import com.game.stalls.message.*;
    import net.*;

    public class ResAuctionLooklogHandler extends Handler
    {

        public function ResAuctionLooklogHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStallsLooklogMessage(this.message);
            AuctionControl.getInstance().setLog(_loc_1.stallslogInfo);
            return;
        }// end function

    }
}
