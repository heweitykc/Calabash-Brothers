package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResReviveSuccessMessage extends Message
    {
        private var _personId:long;
        private var _reason:int;

        public function ResReviveSuccessMessage()
        {
            return;
        }// end function

        public function set personId(param1:long) : void
        {
            this._personId = param1;
            return;
        }// end function

        public function get personId() : long
        {
            return this._personId;
        }// end function

        public function set reason(param1:int) : void
        {
            this._reason = param1;
            return;
        }// end function

        public function get reason() : int
        {
            return this._reason;
        }// end function

        override public function getId() : int
        {
            return 103102;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeByte(this._reason);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._reason = readByte();
            return true;
        }// end function

    }
}
