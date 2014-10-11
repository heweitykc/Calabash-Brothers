package com.game.transactions.handler
{
    import com.game.transactions.message.*;
    import net.*;

    public class ResTransactionsChangeYuanbaoHandler extends Handler
    {

        public function ResTransactionsChangeYuanbaoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTransactionsChangeYuanbaoMessage(this.message);
            return;
        }// end function

    }
}
