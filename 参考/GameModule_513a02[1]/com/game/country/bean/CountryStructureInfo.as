package com.game.country.bean
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class CountryStructureInfo extends Bean
    {
        private var _Siegetime:String;
        private var _guildid:long;
        private var _guildname:String;
        private var _countrymemberInfolist:Vector.<CountryMemberInfo>;
        private var _holdDay:int;
        private var _holdReward:String;

        public function CountryStructureInfo()
        {
            this._countrymemberInfolist = new Vector.<CountryMemberInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._Siegetime);
            writeLong(this._guildid);
            writeString(this._guildname);
            writeShort(this._countrymemberInfolist.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._countrymemberInfolist.length)
            {
                
                writeBean(this._countrymemberInfolist[_loc_1]);
                _loc_1++;
            }
            writeInt(this._holdDay);
            writeString(this._holdReward);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._Siegetime = readString();
            this._guildid = readLong();
            this._guildname = readString();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._countrymemberInfolist[_loc_2] = readBean(CountryMemberInfo) as CountryMemberInfo;
                _loc_2++;
            }
            this._holdDay = readInt();
            this._holdReward = readString();
            return true;
        }// end function

        public function get Siegetime() : String
        {
            return this._Siegetime;
        }// end function

        public function set Siegetime(param1:String) : void
        {
            this._Siegetime = param1;
            return;
        }// end function

        public function get guildid() : long
        {
            return this._guildid;
        }// end function

        public function set guildid(param1:long) : void
        {
            this._guildid = param1;
            return;
        }// end function

        public function get guildname() : String
        {
            return this._guildname;
        }// end function

        public function set guildname(param1:String) : void
        {
            this._guildname = param1;
            return;
        }// end function

        public function get countrymemberInfolist() : Vector.<CountryMemberInfo>
        {
            return this._countrymemberInfolist;
        }// end function

        public function set countrymemberInfolist(param1:Vector.<CountryMemberInfo>) : void
        {
            this._countrymemberInfolist = param1;
            return;
        }// end function

        public function get holdDay() : int
        {
            return this._holdDay;
        }// end function

        public function set holdDay(param1:int) : void
        {
            this._holdDay = param1;
            return;
        }// end function

        public function get holdReward() : String
        {
            return this._holdReward;
        }// end function

        public function set holdReward(param1:String) : void
        {
            this._holdReward = param1;
            return;
        }// end function

    }
}
