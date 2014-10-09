package com.game.toplist.message
{
    import com.game.utils.*;
    import net.*;

    public class ResWorShipToClientMessage extends Message
    {
        private var _errorcode:int;
        private var _worshipnum:int;
        private var _worshipplayerid:long;
        private var _allworshipnum:int;

        public function ResWorShipToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._errorcode);
            writeByte(this._worshipnum);
            writeLong(this._worshipplayerid);
            writeInt(this._allworshipnum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._errorcode = readByte();
            this._worshipnum = readByte();
            this._worshipplayerid = readLong();
            this._allworshipnum = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 142102;
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

        public function get worshipnum() : int
        {
            return this._worshipnum;
        }// end function

        public function set worshipnum(param1:int) : void
        {
            this._worshipnum = param1;
            return;
        }// end function

        public function get worshipplayerid() : long
        {
            return this._worshipplayerid;
        }// end function

        public function set worshipplayerid(param1:long) : void
        {
            this._worshipplayerid = param1;
            return;
        }// end function

        public function get allworshipnum() : int
        {
            return this._allworshipnum;
        }// end function

        public function set allworshipnum(param1:int) : void
        {
            this._allworshipnum = param1;
            return;
        }// end function

    }
}
