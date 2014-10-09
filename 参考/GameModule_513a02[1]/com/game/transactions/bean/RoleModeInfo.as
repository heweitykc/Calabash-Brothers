package com.game.transactions.bean
{
    import com.game.player.bean.*;
    import com.game.utils.*;
    import net.*;

    public class RoleModeInfo extends Bean
    {
        private var _playerid:long;
        private var _playername:String;
        private var _job:int;
        private var _playerlv:int;
        private var _appearanceInfo:PlayerAppearanceInfo;

        public function RoleModeInfo()
        {
            return;
        }// end function

        public function get job() : int
        {
            return this._job;
        }// end function

        public function set job(param1:int) : void
        {
            this._job = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeString(this._playername);
            writeInt(this._playerlv);
            writeByte(this._job);
            writeBean(this._appearanceInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._playername = readString();
            this._playerlv = readInt();
            this._job = readByte();
            this._appearanceInfo = readBean(PlayerAppearanceInfo) as PlayerAppearanceInfo;
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

        public function get playerlv() : int
        {
            return this._playerlv;
        }// end function

        public function set playerlv(param1:int) : void
        {
            this._playerlv = param1;
            return;
        }// end function

        public function get appearanceInfo() : PlayerAppearanceInfo
        {
            return this._appearanceInfo;
        }// end function

        public function set appearanceInfo(param1:PlayerAppearanceInfo) : void
        {
            this._appearanceInfo = param1;
            return;
        }// end function

    }
}
