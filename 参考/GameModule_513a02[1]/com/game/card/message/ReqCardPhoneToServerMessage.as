package com.game.card.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqCardPhoneToServerMessage extends Message
    {
        private var _account:String;
        private var _playerid:long;
        private var _phone:String;

        public function ReqCardPhoneToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._account);
            writeLong(this._playerid);
            writeString(this._phone);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._account = readString();
            this._playerid = readLong();
            this._phone = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 137102;
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

    }
}
