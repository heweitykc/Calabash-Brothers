package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPlayerPkValueChangeMessage extends Message
    {
        private var _personId:long;
        private var _currentPkValue:int;

        public function ResPlayerPkValueChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeInt(this._currentPkValue);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._currentPkValue = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 511400;
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

        public function get currentPkValue() : int
        {
            return this._currentPkValue;
        }// end function

        public function set currentPkValue(param1:int) : void
        {
            this._currentPkValue = param1;
            return;
        }// end function

    }
}
