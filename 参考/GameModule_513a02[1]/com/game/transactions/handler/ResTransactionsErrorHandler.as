package com.game.transactions.handler
{
    import com.game.transactions.message.*;
    import net.*;

    public class ResTransactionsErrorHandler extends Handler
    {

        public function ResTransactionsErrorHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTransactionsErrorMessage(this.message);
            return;
        }// end function

    }
}
