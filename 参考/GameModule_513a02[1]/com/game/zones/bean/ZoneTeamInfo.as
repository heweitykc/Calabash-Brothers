package com.game.zones.bean
{
    import com.game.utils.*;
    import net.*;

    public class ZoneTeamInfo extends Bean
    {
        private var _zoneid:int;
        private var _clearancestatus:int;
        private var _enternum:int;
        private var _isopen:int;
        private var _last_time:long;
        private var _wait_time:long;
        private var _enterMaxnum:int;
        public var zoneType:int;

        public function ZoneTeamInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._zoneid);
            writeByte(this._clearancestatus);
            writeInt(this._enternum);
            writeByte(this._isopen);
            writeLong(this._last_time);
            writeLong(this._wait_time);
            writeInt(this._enterMaxnum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._zoneid = readInt();
            this._clearancestatus = readByte();
            this._enternum = readInt();
            this._isopen = readByte();
            this._last_time = readLong();
            this._wait_time = readLong();
            this._enterMaxnum = readInt();
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

        public function get clearancestatus() : int
        {
            return this._clearancestatus;
        }// end function

        public function set clearancestatus(param1:int) : void
        {
            this._clearancestatus = param1;
            return;
        }// end function

        public function get enternum() : int
        {
            return this._enternum;
        }// end function

        public function set enternum(param1:int) : void
        {
            this._enternum = param1;
            return;
        }// end function

        public function get isopen() : int
        {
            return this._isopen;
        }// end function

        public function set isopen(param1:int) : void
        {
            this._isopen = param1;
            return;
        }// end function

        public function get last_time() : long
        {
            return this._last_time;
        }// end function

        public function set last_time(param1:long) : void
        {
            this._last_time = param1;
            return;
        }// end function

        public function get wait_time() : long
        {
            return this._wait_time;
        }// end function

        public function set wait_time(param1:long) : void
        {
            this._wait_time = param1;
            return;
        }// end function

        public function get enterMaxnum() : int
        {
            return this._enterMaxnum;
        }// end function

        public function set enterMaxnum(param1:int) : void
        {
            this._enterMaxnum = param1;
            return;
        }// end function

    }
}
