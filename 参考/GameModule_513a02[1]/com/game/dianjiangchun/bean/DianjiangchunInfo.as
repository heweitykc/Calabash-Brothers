package com.game.dianjiangchun.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class DianjiangchunInfo extends Bean
    {
        private var _status:int;
        private var _nInfuriatingvalue:int;
        private var _nReceiveintinfuriatingvalue:int;
        private var _btUsecount:int;
        private var _btMaxcount:int;
        private var _btFreechangeluckcount:int;
        private var _btFreechangeluckMaxcount:int;
        private var _bosonList:Vector.<int>;

        public function DianjiangchunInfo()
        {
            this._bosonList = new Vector.<int>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._status);
            writeInt(this._nInfuriatingvalue);
            writeInt(this._nReceiveintinfuriatingvalue);
            writeByte(this._btUsecount);
            writeByte(this._btMaxcount);
            writeByte(this._btFreechangeluckcount);
            writeByte(this._btFreechangeluckMaxcount);
            writeShort(this._bosonList.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._bosonList.length)
            {
                
                writeInt(this._bosonList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._status = readInt();
            this._nInfuriatingvalue = readInt();
            this._nReceiveintinfuriatingvalue = readInt();
            this._btUsecount = readByte();
            this._btMaxcount = readByte();
            this._btFreechangeluckcount = readByte();
            this._btFreechangeluckMaxcount = readByte();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._bosonList[_loc_2] = readInt();
                _loc_2++;
            }
            return true;
        }// end function

        public function get status() : int
        {
            return this._status;
        }// end function

        public function set status(param1:int) : void
        {
            this._status = param1;
            return;
        }// end function

        public function get nInfuriatingvalue() : int
        {
            return this._nInfuriatingvalue;
        }// end function

        public function set nInfuriatingvalue(param1:int) : void
        {
            this._nInfuriatingvalue = param1;
            return;
        }// end function

        public function get nReceiveintinfuriatingvalue() : int
        {
            return this._nReceiveintinfuriatingvalue;
        }// end function

        public function set nReceiveintinfuriatingvalue(param1:int) : void
        {
            this._nReceiveintinfuriatingvalue = param1;
            return;
        }// end function

        public function get btUsecount() : int
        {
            return this._btUsecount;
        }// end function

        public function set btUsecount(param1:int) : void
        {
            this._btUsecount = param1;
            return;
        }// end function

        public function get btMaxcount() : int
        {
            return this._btMaxcount;
        }// end function

        public function set btMaxcount(param1:int) : void
        {
            this._btMaxcount = param1;
            return;
        }// end function

        public function get btFreechangeluckcount() : int
        {
            return this._btFreechangeluckcount;
        }// end function

        public function set btFreechangeluckcount(param1:int) : void
        {
            this._btFreechangeluckcount = param1;
            return;
        }// end function

        public function get btFreechangeluckMaxcount() : int
        {
            return this._btFreechangeluckMaxcount;
        }// end function

        public function set btFreechangeluckMaxcount(param1:int) : void
        {
            this._btFreechangeluckMaxcount = param1;
            return;
        }// end function

        public function get bosonList() : Vector.<int>
        {
            return this._bosonList;
        }// end function

        public function set bosonList(param1:Vector.<int>) : void
        {
            this._bosonList = param1;
            return;
        }// end function

    }
}
