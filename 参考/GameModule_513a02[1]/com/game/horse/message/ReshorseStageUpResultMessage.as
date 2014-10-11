package com.game.horse.message
{
    import net.*;

    public class ReshorseStageUpResultMessage extends Message
    {
        private var _type:int;
        private var _dayblessvalue:int;
        private var _crit:int;
        private var _exp:int;
        private var _itemmodelid:int;
        private var _itemnum:int;
        private var _money:int;
        private var _curlayer:int;

        public function ReshorseStageUpResultMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeInt(this._dayblessvalue);
            writeByte(this._crit);
            writeInt(this._exp);
            writeInt(this._itemmodelid);
            writeInt(this._itemnum);
            writeInt(this._money);
            writeShort(this._curlayer);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._dayblessvalue = readInt();
            this._crit = readByte();
            this._exp = readInt();
            this._itemmodelid = readInt();
            this._itemnum = readInt();
            this._money = readInt();
            this._curlayer = readShort();
            return true;
        }// end function

        override public function getId() : int
        {
            return 126105;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get dayblessvalue() : int
        {
            return this._dayblessvalue;
        }// end function

        public function set dayblessvalue(param1:int) : void
        {
            this._dayblessvalue = param1;
            return;
        }// end function

        public function get crit() : int
        {
            return this._crit;
        }// end function

        public function set crit(param1:int) : void
        {
            this._crit = param1;
            return;
        }// end function

        public function get exp() : int
        {
            return this._exp;
        }// end function

        public function set exp(param1:int) : void
        {
            this._exp = param1;
            return;
        }// end function

        public function get itemmodelid() : int
        {
            return this._itemmodelid;
        }// end function

        public function set itemmodelid(param1:int) : void
        {
            this._itemmodelid = param1;
            return;
        }// end function

        public function get itemnum() : int
        {
            return this._itemnum;
        }// end function

        public function set itemnum(param1:int) : void
        {
            this._itemnum = param1;
            return;
        }// end function

        public function get money() : int
        {
            return this._money;
        }// end function

        public function set money(param1:int) : void
        {
            this._money = param1;
            return;
        }// end function

        public function get curlayer() : int
        {
            return this._curlayer;
        }// end function

        public function set curlayer(param1:int) : void
        {
            this._curlayer = param1;
            return;
        }// end function

    }
}
