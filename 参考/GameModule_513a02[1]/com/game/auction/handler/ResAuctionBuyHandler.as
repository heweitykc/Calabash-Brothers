package com.game.auction.handler
{
    import com.game.auction.control.*;
    import com.game.auction.message.*;
    import net.*;

    public class ResAuctionBuyHandler extends Handler
    {

        public function ResAuctionBuyHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAuctionBuyfinshMessage(this.message);
            AuctionControl.getInstance().buyRes();
            return;
        }// end function

    }
}
