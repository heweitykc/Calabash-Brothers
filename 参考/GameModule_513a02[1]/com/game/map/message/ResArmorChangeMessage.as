package com.game.map.message
{
    import com.game.utils.*;
    import net.*;

    public class ResArmorChangeMessage extends Message
    {
        private var _personId:long;
        private var _armorId:int;
        private var _armorStrength:int;

        public function ResArmorChangeMessage()
        {
            return;
        }// end function

        public function get armorStrength() : int
        {
            return this._armorStrength;
        }// end function

        public function set armorStrength(param1:int) : void
        {
            this._armorStrength = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeInt(this._armorId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._armorId = readInt();
            this._armorStrength = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 101119;
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

        public function get armorId() : int
        {
            return this._armorId;
        }// end function

        public function set armorId(param1:int) : void
        {
            this._armorId = param1;
            return;
        }// end function

    }
}
