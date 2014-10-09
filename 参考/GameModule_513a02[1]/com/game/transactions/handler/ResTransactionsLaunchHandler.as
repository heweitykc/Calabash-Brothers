package com.game.transactions.handler
{
    import com.game.transactions.control.*;
    import com.game.transactions.message.*;
    import net.*;

    public class ResTransactionsLaunchHandler extends Handler
    {

        public function ResTransactionsLaunchHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTransactionsLaunchMessage(this.message);
            TransactionControl.getInstance().launchTransactionRes(_loc_1.launchtime, _loc_1.rolemodeinfo, _loc_1.transid);
            return;
        }// end function

    }
}
