package com.game.stalls.bean
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class StallsInfo extends Bean
    {
        private var _playername:String;
        private var _playerid:long;
        private var _stallslv:int;
        private var _stallsname:String;
        private var _stallsgoodsinfo:Vector.<StallsGoodsInfo>;

        public function StallsInfo()
        {
            this._stallsgoodsinfo = new Vector.<StallsGoodsInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._playername);
            writeLong(this._playerid);
            writeByte(this._stallslv);
            writeString(this._stallsname);
            writeShort(this._stallsgoodsinfo.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._stallsgoodsinfo.length)
            {
                
                writeBean(this._stallsgoodsinfo[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playername = readString();
            this._playerid = readLong();
            this._stallslv = readByte();
            this._stallsname = readString();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._stallsgoodsinfo[_loc_2] = readBean(StallsGoodsInfo) as StallsGoodsInfo;
                _loc_2++;
            }
            return true;
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

        public function get playerid() : long
        {
            return this._playerid;
        }// end function

        public function set playerid(param1:long) : void
        {
            this._playerid = param1;
            return;
        }// end function

        public function get stallslv() : int
        {
            return this._stallslv;
        }// end function

        public function set stallslv(param1:int) : void
        {
            this._stallslv = param1;
            return;
        }// end function

        public function get stallsname() : String
        {
            return this._stallsname;
        }// end function

        public function set stallsname(param1:String) : void
        {
            this._stallsname = param1;
            return;
        }// end function

        public function get stallsgoodsinfo() : Vector.<StallsGoodsInfo>
        {
            return this._stallsgoodsinfo;
        }// end function

        public function set stallsgoodsinfo(param1:Vector.<StallsGoodsInfo>) : void
        {
            this._stallsgoodsinfo = param1;
            return;
        }// end function

    }
}
