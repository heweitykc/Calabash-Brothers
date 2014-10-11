package com.game.transactions.message
{
    import com.game.utils.*;
    import net.*;

    public class ResTransactionsChangeGoldMessage extends Message
    {
        private var _playerid:long;
        private var _gold:int;

        public function ResTransactionsChangeGoldMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeInt(this._gold);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._gold = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 122106;
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

        public function get gold() : int
        {
            return this._gold;
        }// end function

        public function set gold(param1:int) : void
        {
            this._gold = param1;
            return;
        }// end function

    }
}
