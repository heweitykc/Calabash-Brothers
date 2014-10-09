package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPlayerSpeedChangeMessage extends Message
    {
        private var _personId:long;
        private var _speed:int;

        public function ResPlayerSpeedChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeInt(this._speed);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._speed = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103112;
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
