package com.game.zones.message
{
    import __AS3__.vec.*;
    import com.game.zones.bean.*;
    import net.*;

    public class ResZoneNoticeRewardMessage extends Message
    {
        private var _zoneRewardnuminfo:Vector.<ZoneRewardNumInfo>;

        public function ResZoneNoticeRewardMessage()
        {
            this._zoneRewardnuminfo = new Vector.<ZoneRewardNumInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._zoneRewardnuminfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._zoneRewardnuminfo.length)
            {
                
                writeBean(this._zoneRewardnuminfo[_loc_1]);
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
                
                this._zoneRewardnuminfo[_loc_1] = readBean(ZoneRewardNumInfo) as ZoneRewardNumInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 128108;
        }// end function

        public function get zoneRewardnuminfo() : Vector.<ZoneRewardNumInfo>
        {
            return this._zoneRewardnuminfo;
        }// end function

        public function set zoneRewardnuminfo(param1:Vector.<ZoneRewardNumInfo>) : void
        {
            this._zoneRewardnuminfo = param1;
            return;
        }// end function

    }
}
