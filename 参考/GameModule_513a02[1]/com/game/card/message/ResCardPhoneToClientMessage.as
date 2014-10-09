package com.game.card.message
{
    import com.game.utils.*;
    import net.*;

    public class ResCardPhoneToClientMessage extends Message
    {
        private var _errorcode:int;
        private var _status:int;
        private var _account:String;
        private var _playerid:long;
        private var _phone:String;
        private var _agid:int;
        private var _type:int;
        private var _vercode:String;
        private var _phonevernum:int;
        private var _vererrornum:int;

        public function ResCardPhoneToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._errorcode);
            writeByte(this._status);
            writeString(this._account);
            writeLong(this._playerid);
            writeString(this._phone);
            writeInt(this._agid);
            writeInt(this._type);
            writeString(this._vercode);
            writeInt(this._phonevernum);
            writeInt(this._vererrornum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._errorcode = readByte();
            this._status = readByte();
            this._account = readString();
            this._playerid = readLong();
            this._phone = readString();
            this._agid = readInt();
            this._type = readInt();
            this._vercode = readString();
            this._phonevernum = readInt();
            this._vererrornum = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 137251;
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

        public function get status() : int
        {
            return this._status;
        }// end function

        public function set status(param1:int) : void
        {
            this._status = param1;
            return;
        }// end function

        public function get account() : String
        {
            return this._account;
        }// end function

        public function set account(param1:String) : void
        {
            this._account = param1;
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

        public function get phone() : String
        {
            return this._phone;
        }// end function

        public function set phone(param1:String) : void
        {
            this._phone = param1;
            return;
        }// end function

        public function get agid() : int
        {
            return this._agid;
        }// end function

        public function set agid(param1:int) : void
        {
            this._agid = param1;
            return;
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

        public function get vercode() : String
        {
            return this._vercode;
        }// end function

        public function set vercode(param1:String) : void
        {
            this._vercode = param1;
            return;
        }// end function

        public function get phonevernum() : int
        {
            return this._phonevernum;
        }// end function

        public function set phonevernum(param1:int) : void
        {
            this._phonevernum = param1;
            return;
        }// end function

        public function get vererrornum() : int
        {
            return this._vererrornum;
        }// end function

        public function set vererrornum(param1:int) : void
        {
            this._vererrornum = param1;
            return;
        }// end function

    }
}
