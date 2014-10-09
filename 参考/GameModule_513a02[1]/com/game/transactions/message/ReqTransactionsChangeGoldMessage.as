package com.game.transactions.message
{
    import net.*;

    public class ReqTransactionsChangeGoldMessage extends Message
    {
        private var _gold:int;

        public function ReqTransactionsChangeGoldMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._gold);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._gold = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 122207;
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
