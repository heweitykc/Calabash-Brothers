package com.game.country.bean
{
    import com.game.utils.*;
    import net.*;

    public class CountryMemberInfo extends Bean
    {
        private var _post:int;
        private var _playerid:long;
        private var _playername:String;
        private var _sex:int;
        private var _job:int;

        public function CountryMemberInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._post);
            writeLong(this._playerid);
            writeString(this._playername);
            writeInt(this._sex);
            writeInt(this._job);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._post = readByte();
            this._playerid = readLong();
            this._playername = readString();
            this._sex = readInt();
            this._job = readInt();
            return true;
        }// end function

        public function get post() : int
        {
            return this._post;
        }// end function

        public function set post(param1:int) : void
        {
            this._post = param1;
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

        public function get playername() : String
        {
            return this._playername;
        }// end function

        public function set playername(param1:String) : void
        {
            this._playername = param1;
            return;
        }// end function

        public function get sex() : int
        {
            return this._sex;
        }// end function

        public function set sex(param1:int) : void
        {
            this._sex = param1;
            return;
        }// end function

        public function get job() : int
        {
            return this._job;
        }// end function

        public function set job(param1:int) : void
        {
            this._job = param1;
            return;
        }// end function

    }
}
