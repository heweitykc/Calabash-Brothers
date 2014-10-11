package com.game.transactions.message
{
    import com.game.utils.*;
    import net.*;

    public class ResTransactionsSuccessMessage extends Message
    {
        private var _tsexp:long;

        public function ResTransactionsSuccessMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._tsexp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._tsexp = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 122109;
        }// end function

        public function get tsexp() : long
        {
            return this._tsexp;
        }// end function

        public function set tsexp(param1:long) : void
        {
            this._tsexp = param1;
            return;
        }// end function

    }
}
