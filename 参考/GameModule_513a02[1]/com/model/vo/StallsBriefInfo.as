package com.model.vo
{
    import com.game.utils.*;

    public class StallsBriefInfo extends Object
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
        private var _index:int;
        private var _isNpc:int;

        public function StallsBriefInfo()
        {
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

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
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
