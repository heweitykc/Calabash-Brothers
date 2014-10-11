package com.game.transactions.handler
{
    import com.game.transactions.control.*;
    import com.game.transactions.message.*;
    import net.*;

    public class ResTransactionsSuccessHandler extends Handler
    {

        public function ResTransactionsSuccessHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTransactionsSuccessMessage(this.message);
            TransactionControl.getInstance().completeTransaction();
            return;
        }// end function

    }
}
