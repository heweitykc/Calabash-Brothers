package com.game.hiddenweapon.message
{
    import com.game.hiddenweapon.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResOthersHiddenWeaponInfoMessage extends Message
    {
        private var _playerid:long;
        private var _info:OthersHiddenWeaponInfo;

        public function ResOthersHiddenWeaponInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeBean(this._info);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._info = readBean(OthersHiddenWeaponInfo) as OthersHiddenWeaponInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 162105;
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

        public function get info() : OthersHiddenWeaponInfo
        {
            return this._info;
        }// end function

        public function set info(param1:OthersHiddenWeaponInfo) : void
        {
            this._info = param1;
            return;
        }// end function

    }
}
