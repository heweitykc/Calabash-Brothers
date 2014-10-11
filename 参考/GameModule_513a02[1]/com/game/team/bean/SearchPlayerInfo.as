package com.game.team.bean
{
    import com.game.utils.*;
    import net.*;

    public class SearchPlayerInfo extends Bean
    {
        private var _playerid:long;
        private var _playerlv:int;
        private var _playername:String;
        private var _line:int;

        public function SearchPlayerInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeShort(this._playerlv);
            writeString(this._playername);
            writeByte(this._line);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._playerlv = readShort();
            this._playername = readString();
            this._line = readByte();
            return true;
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

        public function get playerlv() : int
        {
            return this._playerlv;
        }// end function

        public function set playerlv(param1:int) : void
        {
            this._playerlv = param1;
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

        public function get line() : int
        {
            return this._line;
        }// end function

        public function set line(param1:int) : void
        {
            this._line = param1;
            return;
        }// end function

    }
}
