package com.game.auction.message
{
    import net.*;

    public class ResAuctionBuyfinshMessage extends Message
    {

        public function ResAuctionBuyfinshMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 512010;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

    }
}
