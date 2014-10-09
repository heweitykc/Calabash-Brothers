package com.game.map.message
{
    import com.game.utils.*;
    import net.*;

    public class ResWeaponChangeMessage extends Message
    {
        private var _personId:long;
        private var _weaponId:int;
        private var _weaponStreng:int;
        private var _pos:int;

        public function ResWeaponChangeMessage()
        {
            return;
        }// end function

        public function get pos() : int
        {
            return this._pos;
        }// end function

        public function set pos(param1:int) : void
        {
            this._pos = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeInt(this._weaponId);
            writeByte(this._weaponStreng);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._weaponId = readInt();
            this._weaponStreng = readByte();
            this._pos = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 101118;
        }// end function

        public function get personId() : long
        {
            return this._personId;
        }// end function

        public function set personId(param1:long) : void
        {
            this._personId = param1;
            return;
        }// end function

        public function get weaponId() : int
        {
            return this._weaponId;
        }// end function

        public function set weaponId(param1:int) : void
        {
            this._weaponId = param1;
            return;
        }// end function

        public function get weaponStreng() : int
        {
            return this._weaponStreng;
        }// end function

        public function set weaponStreng(param1:int) : void
        {
            this._weaponStreng = param1;
            return;
        }// end function

    }
}
