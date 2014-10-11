package com.game.stalls.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqStallsPlayerIdLookMessage extends Message
    {
        private var _playerid:long;

        public function ReqStallsPlayerIdLookMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 123202;
        }// end function

        public function get playerid() : long
        {
            return this._playerid;
        }// end function

        public function set playerid(param1:long) : void
        {
            this._playerid = param1;
            return;
        }// end function

    }
}
