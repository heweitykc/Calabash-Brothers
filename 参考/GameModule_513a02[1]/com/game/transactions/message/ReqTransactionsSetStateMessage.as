package com.game.transactions.message
{
    import net.*;

    public class ReqTransactionsSetStateMessage extends Message
    {
        private var _state:int;

        public function ReqTransactionsSetStateMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._state);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._state = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 122209;
        }// end function

        public function get state() : int
        {
            return this._state;
        }// end function

        public function set state(param1:int) : void
        {
            this._state = param1;
            return;
        }// end function

    }
}
