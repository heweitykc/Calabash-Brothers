package com.game.zones.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class ZoneApplyDataInfo extends Bean
    {
        private var _zoneid:int;
        private var _playernamelist:Vector.<String>;
        private var _playerlvlist:Vector.<int>;

        public function ZoneApplyDataInfo()
        {
            this._playernamelist = new Vector.<String>;
            this._playerlvlist = new Vector.<int>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._zoneid);
            writeShort(this._playernamelist.length);
            _loc_1 = 0;
            while (_loc_1 < this._playernamelist.length)
            {
                
                writeString(this._playernamelist[_loc_1]);
                _loc_1++;
            }
            writeShort(this._playerlvlist.length);
            _loc_1 = 0;
            while (_loc_1 < this._playerlvlist.length)
            {
                
                writeInt(this._playerlvlist[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._zoneid = readInt();
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._playernamelist[_loc_2] = readString();
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._playerlvlist[_loc_2] = readInt();
                _loc_2++;
            }
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

        public function get playernamelist() : Vector.<String>
        {
            return this._playernamelist;
        }// end function

        public function set playernamelist(param1:Vector.<String>) : void
        {
            this._playernamelist = param1;
            return;
        }// end function

        public function get playerlvlist() : Vector.<int>
        {
            return this._playerlvlist;
        }// end function

        public function set playerlvlist(param1:Vector.<int>) : void
        {
            this._playerlvlist = param1;
            return;
        }// end function

    }
}
