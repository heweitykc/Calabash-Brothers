package com.game.transactions.handler
{
    import com.game.transactions.control.*;
    import com.game.transactions.message.*;
    import net.*;

    public class ResTransactionsCanceledHandler extends Handler
    {

        public function ResTransactionsCanceledHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTransactionsCanceledMessage(this.message);
            TransactionControl.getInstance().cancelTransactionsRes();
            return;
        }// end function

    }
}
