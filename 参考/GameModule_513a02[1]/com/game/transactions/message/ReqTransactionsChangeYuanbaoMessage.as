package com.game.transactions.message
{
    import net.*;

    public class ReqTransactionsChangeYuanbaoMessage extends Message
    {
        private var _yuanbao:int;

        public function ReqTransactionsChangeYuanbaoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._yuanbao);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._yuanbao = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 122208;
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
