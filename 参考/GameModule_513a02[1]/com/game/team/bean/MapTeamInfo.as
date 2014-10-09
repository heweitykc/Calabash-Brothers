package com.game.team.bean
{
    import com.game.utils.*;
    import net.*;

    public class MapTeamInfo extends Bean
    {
        private var _teamid:long;
        private var _captainid:long;
        private var _captainname:String;
        private var _teamnum:int;
        private var _captainlv:int;
        private var _highestlv:int;
        private var _averagelv:int;
        private var _line:int;

        public function MapTeamInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._teamid);
            writeLong(this._captainid);
            writeString(this._captainname);
            writeByte(this._teamnum);
            writeShort(this._captainlv);
            writeShort(this._highestlv);
            writeShort(this._averagelv);
            writeByte(this._line);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._teamid = readLong();
            this._captainid = readLong();
            this._captainname = readString();
            this._teamnum = readByte();
            this._captainlv = readShort();
            this._highestlv = readShort();
            this._averagelv = readShort();
            this._line = readByte();
            return true;
        }// end function

        public function get teamid() : long
        {
            return this._teamid;
        }// end function

        public function set teamid(param1:long) : void
        {
            this._teamid = param1;
            return;
        }// end function

        public function get captainid() : long
        {
            return this._captainid;
        }// end function

        public function set captainid(param1:long) : void
        {
            this._captainid = param1;
            return;
        }// end function

        public function get captainname() : String
        {
            return this._captainname;
        }// end function

        public function set captainname(param1:String) : void
        {
            this._captainname = param1;
            return;
        }// end function

        public function get teamnum() : int
        {
            return this._teamnum;
        }// end function

        public function set teamnum(param1:int) : void
        {
            this._teamnum = param1;
            return;
        }// end function

        public function get captainlv() : int
        {
            return this._captainlv;
        }// end function

        public function set captainlv(param1:int) : void
        {
            this._captainlv = param1;
            return;
        }// end function

        public function get highestlv() : int
        {
            return this._highestlv;
        }// end function

        public function set highestlv(param1:int) : void
        {
            this._highestlv = param1;
            return;
        }// end function

        public function get averagelv() : int
        {
            return this._averagelv;
        }// end function

        public function set averagelv(param1:int) : void
        {
            this._averagelv = param1;
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
