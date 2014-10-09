package com.game.monster.message
{
    import com.game.utils.*;
    import net.*;

    public class ResMonsterSpeedChangeMessage extends Message
    {
        private var _monsterId:long;
        private var _speed:int;

        public function ResMonsterSpeedChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._monsterId);
            writeInt(this._speed);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._monsterId = readLong();
            this._speed = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 114107;
        }// end function

        public function get monsterId() : long
        {
            return this._monsterId;
        }// end function

        public function set monsterId(param1:long) : void
        {
            this._monsterId = param1;
            return;
        }// end function

        public function get speed() : int
        {
            return this._speed;
        }// end function

        public function set speed(param1:int) : void
        {
            this._speed = param1;
            return;
        }// end function

    }
}
