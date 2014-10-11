package com.game.auction.message
{
    import com.game.auction.bean.*;
    import net.*;

    public class ResAuctionShowItemMessage extends Message
    {
        private var _viplv:int;
        private var _viptype:int;
        private var _auctionInfo:AuctionInfoBean;

        public function ResAuctionShowItemMessage()
        {
            return;
        }// end function

        public function get viptype() : int
        {
            return this._viptype;
        }// end function

        public function set viptype(param1:int) : void
        {
            this._viptype = param1;
            return;
        }// end function

        public function set viplv(param1:int) : void
        {
            this._viplv = param1;
            return;
        }// end function

        public function get viplv() : int
        {
            return this._viplv;
        }// end function

        public function set auctionInfo(param1:AuctionInfoBean) : void
        {
            this._auctionInfo = param1;
            return;
        }// end function

        public function get auctionInfo() : AuctionInfoBean
        {
            return this._auctionInfo;
        }// end function

        override public function getId() : int
        {
            return 512009;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._viplv);
            writeInt(this._viptype);
            writeBean(this._auctionInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._viplv = readInt();
            this._viptype = readInt();
            this._auctionInfo = readBean(AuctionInfoBean) as AuctionInfoBean;
            return true;
        }// end function

    }
}
