package com.game.zones.message
{
    import com.game.zones.bean.*;
    import net.*;

    public class ResZoneKillProgressRateMessage extends Message
    {
        private var _zoneid:int;
        private var _monstrssum:int;
        private var _monstrsnum:int;
        private var _deathnum:int;
        private var _status:int;
        private var _zoenmonstrinfo:ZoneMonstrInfo;

        public function ResZoneKillProgressRateMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._zoneid);
            writeInt(this._monstrssum);
            writeInt(this._monstrsnum);
            writeInt(this._deathnum);
            writeByte(this._status);
            writeBean(this._zoenmonstrinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._zoneid = readInt();
            this._monstrssum = readInt();
            this._monstrsnum = readInt();
            this._deathnum = readInt();
            this._status = readByte();
            this._zoenmonstrinfo = readBean(ZoneMonstrInfo) as ZoneMonstrInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 128109;
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

        public function get monstrssum() : int
        {
            return this._monstrssum;
        }// end function

        public function set monstrssum(param1:int) : void
        {
            this._monstrssum = param1;
            return;
        }// end function

        public function get monstrsnum() : int
        {
            return this._monstrsnum;
        }// end function

        public function set monstrsnum(param1:int) : void
        {
            this._monstrsnum = param1;
            return;
        }// end function

        public function get deathnum() : int
        {
            return this._deathnum;
        }// end function

        public function set deathnum(param1:int) : void
        {
            this._deathnum = param1;
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

        public function get zoenmonstrinfo() : ZoneMonstrInfo
        {
            return this._zoenmonstrinfo;
        }// end function

        public function set zoenmonstrinfo(param1:ZoneMonstrInfo) : void
        {
            this._zoenmonstrinfo = param1;
            return;
        }// end function

    }
}
