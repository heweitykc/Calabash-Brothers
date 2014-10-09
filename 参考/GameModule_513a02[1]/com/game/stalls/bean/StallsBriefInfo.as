package com.game.stalls.bean
{
    import com.game.utils.*;
    import net.*;

    public class StallsBriefInfo extends Bean
    {
        private var _playername:String;
        private var _playerid:long;
        private var _playerlv:int;
        private var _stallsid:int;
        private var _stallslv:int;
        private var _stallsname:String;
        private var _sellgold:int;
        private var _sellyuanbao:int;
        private var _sellgoodsnum:int;

        public function StallsBriefInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._playername);
            writeLong(this._playerid);
            writeShort(this._playerlv);
            writeInt(this._stallsid);
            writeByte(this._stallslv);
            writeString(this._stallsname);
            writeInt(this._sellgold);
            writeInt(this._sellyuanbao);
            writeByte(this._sellgoodsnum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playername = readString();
            this._playerid = readLong();
            this._playerlv = readShort();
            this._stallsid = readInt();
            this._stallslv = readByte();
            this._stallsname = readString();
            this._sellgold = readInt();
            this._sellyuanbao = readInt();
            this._sellgoodsnum = readByte();
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

        public function get playerlv() : int
        {
            return this._playerlv;
        }// end function

        public function set playerlv(param1:int) : void
        {
            this._playerlv = param1;
            return;
        }// end function

        public function get stallsid() : int
        {
            return this._stallsid;
        }// end function

        public function set stallsid(param1:int) : void
        {
            this._stallsid = param1;
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

        public function get sellgold() : int
        {
            return this._sellgold;
        }// end function

        public function set sellgold(param1:int) : void
        {
            this._sellgold = param1;
            return;
        }// end function

        public function get sellyuanbao() : int
        {
            return this._sellyuanbao;
        }// end function

        public function set sellyuanbao(param1:int) : void
        {
            this._sellyuanbao = param1;
            return;
        }// end function

        public function get sellgoodsnum() : int
        {
            return this._sellgoodsnum;
        }// end function

        public function set sellgoodsnum(param1:int) : void
        {
            this._sellgoodsnum = param1;
            return;
        }// end function

    }
}
