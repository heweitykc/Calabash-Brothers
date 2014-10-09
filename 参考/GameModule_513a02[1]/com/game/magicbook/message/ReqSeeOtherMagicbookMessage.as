package com.game.magicbook.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqSeeOtherMagicbookMessage extends Message
    {
        private var _playerId:long;

        public function ReqSeeOtherMagicbookMessage()
        {
            return;
        }// end function

        public function set playerId(param1:long) : void
        {
            this._playerId = param1;
            return;
        }// end function

        public function get playerId() : long
        {
            return this._playerId;
        }// end function

        override public function getId() : int
        {
            return 600208;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerId = readLong();
            return true;
        }// end function

    }
}
