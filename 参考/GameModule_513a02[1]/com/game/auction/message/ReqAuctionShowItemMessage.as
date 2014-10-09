package com.game.auction.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqAuctionShowItemMessage extends Message
    {
        private var _playerId:long;
        private var _goodsid:long;

        public function ReqAuctionShowItemMessage()
        {
            return;
        }// end function

        public function set playerId(param1:long) : void
        {
            this._playerId = param1;
            return;
        }// end function

        public function get playerId() : long
        {
            return this._playerId;
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
            return 512208;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerId);
            writeLong(this._goodsid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerId = readLong();
            this._goodsid = readLong();
            return true;
        }// end function

    }
}
