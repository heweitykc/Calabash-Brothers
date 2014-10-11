package com.game.zones.message
{
    import __AS3__.vec.*;
    import com.game.zones.bean.*;
    import net.*;

    public class ResAllRaidZoneInfoMessage extends Message
    {
        private var _raidzoneinfolist:Vector.<RaidZoneInfo>;

        public function ResAllRaidZoneInfoMessage()
        {
            this._raidzoneinfolist = new Vector.<RaidZoneInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._raidzoneinfolist.length);
            _loc_1 = 0;
            while (_loc_1 < this._raidzoneinfolist.length)
            {
                
                writeBean(this._raidzoneinfolist[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._raidzoneinfolist[_loc_1] = readBean(RaidZoneInfo) as RaidZoneInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 128106;
        }// end function

        public function get raidzoneinfolist() : Vector.<RaidZoneInfo>
        {
            return this._raidzoneinfolist;
        }// end function

        public function set raidzoneinfolist(param1:Vector.<RaidZoneInfo>) : void
        {
            this._raidzoneinfolist = param1;
            return;
        }// end function

    }
}
