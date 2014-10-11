package com.model.vo
{
    import com.game.utils.*;

    public class AuctionItemInfo extends Object
    {
        private var _playername:String;
        private var _playerid:long;
        private var _playerlv:int;
        private var _stallsid:int;
        private var _stallslv:int;
        private var _stallsname:String;
        private var _sellgold:int;
        private var _sellyuanbao:int;
        private var _sellgoodsnum:int;
        private var _unitprice:int;
        private var _price:int;
        private var _isNpc:int;
        private var _itemId:long;
        private var _deleteTime:long;
        private var _item:PropInfo;

        public function AuctionItemInfo()
        {
            return;
        }// end function

        public function get itemId() : long
        {
            return this._itemId;
        }// end function

        public function set itemId(param1:long) : void
        {
            this._itemId = param1;
            return;
        }// end function

        public function get item() : PropInfo
        {
            return this._item;
        }// end function

        public function set item(param1:PropInfo) : void
        {
            this._item = param1;
            return;
        }// end function

        public function get price() : int
        {
            return this._price;
        }// end function

        public function set price(param1:int) : void
        {
            this._price = param1;
            return;
        }// end function

        public function get unitprice() : int
        {
            return this._unitprice;
        }// end function

        public function set unitprice(param1:int) : void
        {
            this._unitprice = param1;
            return;
        }// end function

        public function get isNpc() : int
        {
            return this._isNpc;
        }// end function

        public function set isNpc(param1:int) : void
        {
            this._isNpc = param1;
            return;
        }// end function

        public function get sellgoodsnum() : int
        {
            return this._sellgoodsnum;
        }// end function

        public function set sellgoodsnum(param1:int) : void
        {
            this._sellgoodsnum = param1;
            return;
        }// end function

        public function get sellyuanbao() : int
        {
            return this._sellyuanbao;
        }// end function

        public function set sellyuanbao(param1:int) : void
        {
            this._sellyuanbao = param1;
            return;
        }// end function

        public function get sellgold() : int
        {
            return this._sellgold;
        }// end function

        public function set sellgold(param1:int) : void
        {
            this._sellgold = param1;
            return;
        }// end function

        public function get stallsname() : String
        {
            return this._stallsname;
        }// end function

        public function set stallsname(param1:String) : void
        {
            this._stallsname = param1;
            return;
        }// end function

        public function get stallslv() : int
        {
            return this._stallslv;
        }// end function

        public function set stallslv(param1:int) : void
        {
            this._stallslv = param1;
            return;
        }// end function

        public function get stallsid() : int
        {
            return this._stallsid;
        }// end function

        public function set stallsid(param1:int) : void
        {
            this._stallsid = param1;
            return;
        }// end function

        public function get playerlv() : int
        {
            return this._playerlv;
        }// end function

        public function set playerlv(param1:int) : void
        {
            this._playerlv = param1;
            return;
        }// end function

        public function get playerid() : long
        {
            return this._playerid;
        }// end function

        public function set playerid(param1:long) : void
        {
            this._playerid = param1;
            return;
        }// end function

        public function get playername() : String
        {
            return this._playername;
        }// end function

        public function set playername(param1:String) : void
        {
            this._playername = param1;
            return;
        }// end function

    }
}
