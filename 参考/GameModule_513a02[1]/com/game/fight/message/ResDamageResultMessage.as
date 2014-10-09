package com.game.fight.message
{
    import com.game.utils.*;
    import net.*;

    public class ResDamageResultMessage extends Message
    {
        private var _playerID:long;
        private var _type:int;
        private var _blood:int;

        public function ResDamageResultMessage()
        {
            return;
        }// end function

        public function get playerID() : long
        {
            return this._playerID;
        }// end function

        public function set playerID(param1:long) : void
        {
            this._playerID = param1;
            return;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set blood(param1:int) : void
        {
            this._blood = param1;
            return;
        }// end function

        public function get blood() : int
        {
            return this._blood;
        }// end function

        override public function getId() : int
        {
            return 601101;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerID);
            writeByte(this._type);
            writeInt(this._blood);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerID = readLong();
            this._type = readByte();
            this._blood = readInt();
            return true;
        }// end function

    }
}
