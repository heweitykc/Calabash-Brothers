package com.game.auction.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqAuctionAddMessage extends Message
    {
        private var _goodsid:long;
        private var _price:int;
        private var _num:int;

        public function ReqAuctionAddMessage()
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

        public function set price(param1:int) : void
        {
            this._price = param1;
            return;
        }// end function

        public function get price() : int
        {
            return this._price;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        override public function getId() : int
        {
            return 512201;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._goodsid);
            writeInt(this._price);
            writeInt(this._num);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._goodsid = readLong();
            this._price = readInt();
            this._num = readInt();
            return true;
        }// end function

    }
}
