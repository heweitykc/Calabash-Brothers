package com.game.zones.message
{
    import __AS3__.vec.*;
    import com.game.zones.bean.*;
    import net.*;

    public class ResZoneTimerMessage extends Message
    {
        private var _zoneid:int;
        private var _monstrssum:int;
        private var _monstrsnum:int;
        private var _deathnum:int;
        private var _surplustime:int;
        private var _status:int;
        private var _zoenmonstrinfolist:Vector.<ZoneMonstrInfo>;

        public function ResZoneTimerMessage()
        {
            this._zoenmonstrinfolist = new Vector.<ZoneMonstrInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._zoneid);
            writeInt(this._monstrssum);
            writeInt(this._monstrsnum);
            writeInt(this._deathnum);
            writeInt(this._surplustime);
            writeByte(this._status);
            writeShort(this._zoenmonstrinfolist.length);
            _loc_1 = 0;
            while (_loc_1 < this._zoenmonstrinfolist.length)
            {
                
                writeBean(this._zoenmonstrinfolist[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._zoneid = readInt();
            this._monstrssum = readInt();
            this._monstrsnum = readInt();
            this._deathnum = readInt();
            this._surplustime = readInt();
            this._status = readByte();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._zoenmonstrinfolist[_loc_1] = readBean(ZoneMonstrInfo) as ZoneMonstrInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 128102;
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

        public function get surplustime() : int
        {
            return this._surplustime;
        }// end function

        public function set surplustime(param1:int) : void
        {
            this._surplustime = param1;
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

        public function get zoenmonstrinfolist() : Vector.<ZoneMonstrInfo>
        {
            return this._zoenmonstrinfolist;
        }// end function

        public function set zoenmonstrinfolist(param1:Vector.<ZoneMonstrInfo>) : void
        {
            this._zoenmonstrinfolist = param1;
            return;
        }// end function

    }
}
