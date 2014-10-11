package com.game.stalls.bean
{
    import com.game.backpack.bean.*;
    import com.game.utils.*;
    import net.*;

    public class StallsSingleLogInfo extends Bean
    {
        private var _transactiontime:int;
        private var _transactiontype:int;
        private var _tradersname:String;
        private var _tradersid:long;
        private var _pricegold:int;
        private var _priceyuanbao:int;
        private var _iteminfo:ItemInfo;

        public function StallsSingleLogInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._transactiontime);
            writeByte(this._transactiontype);
            writeString(this._tradersname);
            writeLong(this._tradersid);
            writeInt(this._pricegold);
            writeInt(this._priceyuanbao);
            writeBean(this._iteminfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._transactiontime = readInt();
            this._transactiontype = readByte();
            this._tradersname = readString();
            this._tradersid = readLong();
            this._pricegold = readInt();
            this._priceyuanbao = readInt();
            this._iteminfo = readBean(ItemInfo) as ItemInfo;
            return true;
        }// end function

        public function get transactiontime() : int
        {
            return this._transactiontime;
        }// end function

        public function set transactiontime(param1:int) : void
        {
            this._transactiontime = param1;
            return;
        }// end function

        public function get transactiontype() : int
        {
            return this._transactiontype;
        }// end function

        public function set transactiontype(param1:int) : void
        {
            this._transactiontype = param1;
            return;
        }// end function

        public function get tradersname() : String
        {
            return this._tradersname;
        }// end function

        public function set tradersname(param1:String) : void
        {
            this._tradersname = param1;
            return;
        }// end function

        public function get tradersid() : long
        {
            return this._tradersid;
        }// end function

        public function set tradersid(param1:long) : void
        {
            this._tradersid = param1;
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

        public function get iteminfo() : ItemInfo
        {
            return this._iteminfo;
        }// end function

        public function set iteminfo(param1:ItemInfo) : void
        {
            this._iteminfo = param1;
            return;
        }// end function

    }
}
