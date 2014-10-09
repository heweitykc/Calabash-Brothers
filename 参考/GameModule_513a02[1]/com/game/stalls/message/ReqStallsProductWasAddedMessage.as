package com.game.stalls.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqStallsProductWasAddedMessage extends Message
    {
        private var _goodsid:long;
        private var _pricegold:int;
        private var _priceyuanbao:int;
        private var _num:int;
        private var _goodsnum:int;

        public function ReqStallsProductWasAddedMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._goodsid);
            writeInt(this._pricegold);
            writeInt(this._priceyuanbao);
            writeInt(this._num);
            writeInt(this._goodsnum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._goodsid = readLong();
            this._pricegold = readInt();
            this._priceyuanbao = readInt();
            this._num = readInt();
            this._goodsnum = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 123205;
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

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
        }// end function

        public function get goodsnum() : int
        {
            return this._goodsnum;
        }// end function

        public function set goodsnum(param1:int) : void
        {
            this._goodsnum = param1;
            return;
        }// end function

    }
}
