package com.game.stalls.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqStallsBuyMessage extends Message
    {
        private var _playerid:long;
        private var _pricegold:int;
        private var _priceyuanbao:int;
        private var _goodsid:long;

        public function ReqStallsBuyMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeInt(this._pricegold);
            writeInt(this._priceyuanbao);
            writeLong(this._goodsid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._pricegold = readInt();
            this._priceyuanbao = readInt();
            this._goodsid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 123204;
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

        public function get pricegold() : int
        {
            return this._pricegold;
        }// end function

        public function set pricegold(param1:int) : void
        {
            this._pricegold = param1;
            return;
        }// end function

        public function get priceyuanbao() : int
        {
            return this._priceyuanbao;
        }// end function

        public function set priceyuanbao(param1:int) : void
        {
            this._priceyuanbao = param1;
            return;
        }// end function

        public function get goodsid() : long
        {
            return this._goodsid;
        }// end function

        public function set goodsid(param1:long) : void
        {
            this._goodsid = param1;
            return;
        }// end function

    }
}
