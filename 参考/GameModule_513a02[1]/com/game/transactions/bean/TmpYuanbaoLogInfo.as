package com.game.transactions.bean
{
    import com.game.backpack.bean.*;
    import com.game.utils.*;
    import net.*;

    public class TmpYuanbaoLogInfo extends Bean
    {
        private var _playerid:long;
        private var _playername:String;
        private var _type:int;
        private var _time:int;
        private var _iteminfo:ItemInfo;
        private var _num:int;
        private var _goldnum:int;
        private var _yuanbaonum:int;

        public function TmpYuanbaoLogInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeString(this._playername);
            writeByte(this._type);
            writeInt(this._time);
            writeBean(this._iteminfo);
            writeInt(this._num);
            writeInt(this._goldnum);
            writeInt(this._yuanbaonum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._playername = readString();
            this._type = readByte();
            this._time = readInt();
            this._iteminfo = readBean(ItemInfo) as ItemInfo;
            this._num = readInt();
            this._goldnum = readInt();
            this._yuanbaonum = readInt();
            return true;
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

        public function get playername() : String
        {
            return this._playername;
        }// end function

        public function set playername(param1:String) : void
        {
            this._playername = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get time() : int
        {
            return this._time;
        }// end function

        public function set time(param1:int) : void
        {
            this._time = param1;
            return;
        }// end function

        public function get iteminfo() : ItemInfo
        {
            return this._iteminfo;
        }// end function

        public function set iteminfo(param1:ItemInfo) : void
        {
            this._iteminfo = param1;
            return;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
        }// end function

        public function get goldnum() : int
        {
            return this._goldnum;
        }// end function

        public function set goldnum(param1:int) : void
        {
            this._goldnum = param1;
            return;
        }// end function

        public function get yuanbaonum() : int
        {
            return this._yuanbaonum;
        }// end function

        public function set yuanbaonum(param1:int) : void
        {
            this._yuanbaonum = param1;
            return;
        }// end function

    }
}
