package com.game.toplist.message
{
    import __AS3__.vec.*;
    import net.*;

    public class ResGetTopTitleToClientMessage extends Message
    {
        private var _errorcode:int;
        private var _titleidlist:Vector.<int>;

        public function ResGetTopTitleToClientMessage()
        {
            this._titleidlist = new Vector.<int>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeByte(this._errorcode);
            writeShort(this._titleidlist.length);
            _loc_1 = 0;
            while (_loc_1 < this._titleidlist.length)
            {
                
                writeInt(this._titleidlist[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._errorcode = readByte();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._titleidlist[_loc_1] = readInt();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 142150;
        }// end function

        public function get errorcode() : int
        {
            return this._errorcode;
        }// end function

        public function set errorcode(param1:int) : void
        {
            this._errorcode = param1;
            return;
        }// end function

        public function get titleidlist() : Vector.<int>
        {
            return this._titleidlist;
        }// end function

        public function set titleidlist(param1:Vector.<int>) : void
        {
            this._titleidlist = param1;
            return;
        }// end function

    }
}
