package com.game.transactions.message
{
    import com.game.utils.*;
    import net.*;

    public class ResTransactionsChangeYuanbaoMessage extends Message
    {
        private var _playerid:long;
        private var _yuanbao:int;

        public function ResTransactionsChangeYuanbaoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeInt(this._yuanbao);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._yuanbao = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 122107;
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

        public function get yuanbao() : int
        {
            return this._yuanbao;
        }// end function

        public function set yuanbao(param1:int) : void
        {
            this._yuanbao = param1;
            return;
        }// end function

    }
}
