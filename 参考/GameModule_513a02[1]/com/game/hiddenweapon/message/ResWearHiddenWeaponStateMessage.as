package com.game.hiddenweapon.message
{
    import com.game.utils.*;
    import net.*;

    public class ResWearHiddenWeaponStateMessage extends Message
    {
        private var _playerid:long;
        private var _curlayer:int;
        private var _status:int;

        public function ResWearHiddenWeaponStateMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeShort(this._curlayer);
            writeByte(this._status);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._curlayer = readShort();
            this._status = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 162102;
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

        public function get curlayer() : int
        {
            return this._curlayer;
        }// end function

        public function set curlayer(param1:int) : void
        {
            this._curlayer = param1;
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

    }
}
