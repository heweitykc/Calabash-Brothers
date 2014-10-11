package com.game.login.message
{
    import com.game.utils.*;
    import net.*;

    public class ResDeleteSuccessMessage extends Message
    {
        private var _playerId:long;

        public function ResDeleteSuccessMessage()
        {
            return;
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

        override public function getId() : int
        {
            return 100105;
        }// end function

        public function get playerId() : long
        {
            return this._playerId;
        }// end function

        public function set playerId(param1:long) : void
        {
            this._playerId = param1;
            return;
        }// end function

    }
}
