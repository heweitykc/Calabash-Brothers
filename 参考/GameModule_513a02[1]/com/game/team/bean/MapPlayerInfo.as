package com.game.team.bean
{
    import com.game.utils.*;
    import net.*;

    public class MapPlayerInfo extends Bean
    {
        private var _playerid:long;
        private var _playerlv:int;
        private var _teamstate:int;
        private var _playername:String;
        private var _guildname:String;
        private var _line:int;
        private var _playerJob:int;

        public function MapPlayerInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeShort(this._playerlv);
            writeByte(this._teamstate);
            writeString(this._playername);
            writeString(this._guildname);
            writeByte(this._line);
            writeByte(this._playerJob);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._playerlv = readShort();
            this._teamstate = readByte();
            this._playername = readString();
            this._guildname = readString();
            this._line = readByte();
            this._playerJob = readByte();
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

        public function get teamstate() : int
        {
            return this._teamstate;
        }// end function

        public function set teamstate(param1:int) : void
        {
            this._teamstate = param1;
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

        public function get guildname() : String
        {
            return this._guildname;
        }// end function

        public function set guildname(param1:String) : void
        {
            this._guildname = param1;
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

        public function get playerJob() : int
        {
            return this._playerJob;
        }// end function

        public function set playerJob(param1:int) : void
        {
            this._playerJob = param1;
            return;
        }// end function

    }
}
