package com.game.transactions.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqTransactionsRefuseMessage extends Message
    {
        private var _transid:long;

        public function ReqTransactionsRefuseMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._transid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._transid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 122203;
        }// end function

        public function get transid() : long
        {
            return this._transid;
        }// end function

        public function set transid(param1:long) : void
        {
            this._transid = param1;
            return;
        }// end function

    }
}
