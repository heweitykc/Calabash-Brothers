package com.game.transactions.message
{
    import net.*;

    public class ResTransactionsErrorMessage extends Message
    {
        private var _errorid:int;

        public function ResTransactionsErrorMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._errorid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._errorid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 122111;
        }// end function

        public function get errorid() : int
        {
            return this._errorid;
        }// end function

        public function set errorid(param1:int) : void
        {
            this._errorid = param1;
            return;
        }// end function

    }
}
