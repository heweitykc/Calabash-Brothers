package com.game.stalls.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqStallsAdjustPricesMessage extends Message
    {
        private var _goodsid:long;
        private var _goodsmodelid:int;
        private var _pricegold:int;
        private var _priceyuanbao:int;
        private var _pos:int;
        private var _num:int;
        private var _currentnum:int;

        public function ReqStallsAdjustPricesMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._goodsid);
            writeInt(this._goodsmodelid);
            writeInt(this._pricegold);
            writeInt(this._priceyuanbao);
            writeInt(this._pos);
            writeInt(this._num);
            writeInt(this._currentnum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._goodsid = readLong();
            this._goodsmodelid = readInt();
            this._pricegold = readInt();
            this._priceyuanbao = readInt();
            this._pos = readInt();
            this._num = readInt();
            this._currentnum = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 123206;
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

        public function get goodsmodelid() : int
        {
            return this._goodsmodelid;
        }// end function

        public function set goodsmodelid(param1:int) : void
        {
            this._goodsmodelid = param1;
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

        public function get pos() : int
        {
            return this._pos;
        }// end function

        public function set pos(param1:int) : void
        {
            this._pos = param1;
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

        public function get currentnum() : int
        {
            return this._currentnum;
        }// end function

        public function set currentnum(param1:int) : void
        {
            this._currentnum = param1;
            return;
        }// end function

    }
}
