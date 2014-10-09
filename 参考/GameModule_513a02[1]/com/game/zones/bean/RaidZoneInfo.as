package com.game.zones.bean
{
    import net.*;

    public class RaidZoneInfo extends Bean
    {
        private var _zoneid:int;
        private var _throughtime:int;
        private var _ranking:int;
        private var _manualmun:int;
        private var _automun:int;
        private var _starnum:int;
        private var _fulltime:int;
        private var _fullname:String;
        private var _clearance:int;
        private var _zhanhunnum:int;

        public function RaidZoneInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._zoneid);
            writeInt(this._throughtime);
            writeInt(this._ranking);
            writeByte(this._manualmun);
            writeByte(this._automun);
            writeByte(this._starnum);
            writeInt(this._fulltime);
            writeString(this._fullname);
            writeByte(this._clearance);
            writeInt(this._zhanhunnum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._zoneid = readInt();
            this._throughtime = readInt();
            this._ranking = readInt();
            this._manualmun = readByte();
            this._automun = readByte();
            this._starnum = readByte();
            this._fulltime = readInt();
            this._fullname = readString();
            this._clearance = readByte();
            this._zhanhunnum = readInt();
            return true;
        }// end function

        public function get zoneid() : int
        {
            return this._zoneid;
        }// end function

        public function set zoneid(param1:int) : void
        {
            this._zoneid = param1;
            return;
        }// end function

        public function get throughtime() : int
        {
            return this._throughtime;
        }// end function

        public function set throughtime(param1:int) : void
        {
            this._throughtime = param1;
            return;
        }// end function

        public function get ranking() : int
        {
            return this._ranking;
        }// end function

        public function set ranking(param1:int) : void
        {
            this._ranking = param1;
            return;
        }// end function

        public function get manualmun() : int
        {
            return this._manualmun;
        }// end function

        public function set manualmun(param1:int) : void
        {
            this._manualmun = param1;
            return;
        }// end function

        public function get automun() : int
        {
            return this._automun;
        }// end function

        public function set automun(param1:int) : void
        {
            this._automun = param1;
            return;
        }// end function

        public function get starnum() : int
        {
            return this._starnum;
        }// end function

        public function set starnum(param1:int) : void
        {
            this._starnum = param1;
            return;
        }// end function

        public function get fulltime() : int
        {
            return this._fulltime;
        }// end function

        public function set fulltime(param1:int) : void
        {
            this._fulltime = param1;
            return;
        }// end function

        public function get fullname() : String
        {
            return this._fullname;
        }// end function

        public function set fullname(param1:String) : void
        {
            this._fullname = param1;
            return;
        }// end function

        public function get clearance() : int
        {
            return this._clearance;
        }// end function

        public function set clearance(param1:int) : void
        {
            this._clearance = param1;
            return;
        }// end function

        public function get zhanhunnum() : int
        {
            return this._zhanhunnum;
        }// end function

        public function set zhanhunnum(param1:int) : void
        {
            this._zhanhunnum = param1;
            return;
        }// end function

    }
}
