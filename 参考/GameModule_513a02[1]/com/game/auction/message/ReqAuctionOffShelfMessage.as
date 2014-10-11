package com.game.auction.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqAuctionOffShelfMessage extends Message
    {
        private var _goodsid:long;

        public function ReqAuctionOffShelfMessage()
        {
            return;
        }// end function

        public function set goodsid(param1:long) : void
        {
            this._goodsid = param1;
            return;
        }// end function

        public function get goodsid() : long
        {
            return this._goodsid;
        }// end function

        override public function getId() : int
        {
            return 512203;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._goodsid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._goodsid = readLong();
            return true;
        }// end function

    }
}
