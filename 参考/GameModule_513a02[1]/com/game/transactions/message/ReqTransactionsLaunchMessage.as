package com.game.transactions.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqTransactionsLaunchMessage extends Message
    {
        private var _playerid:long;

        public function ReqTransactionsLaunchMessage()
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
            return 122201;
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
