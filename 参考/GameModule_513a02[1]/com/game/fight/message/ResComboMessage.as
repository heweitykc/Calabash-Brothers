package com.game.fight.message
{
    import com.game.utils.*;
    import net.*;

    public class ResComboMessage extends Message
    {
        private var _playerid:long;
        private var _value:int;

        public function ResComboMessage()
        {
            return;
        }// end function

        public function set playerid(param1:long) : void
        {
            this._playerid = param1;
            return;
        }// end function

        public function get playerid() : long
        {
            return this._playerid;
        }// end function

        public function set value(param1:int) : void
        {
            this._value = param1;
            return;
        }// end function

        public function get value() : int
        {
            return this._value;
        }// end function

        override public function getId() : int
        {
            return 512110;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeInt(this._value);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._value = readInt();
            return true;
        }// end function

    }
}
