package com.game.transactions.handler
{
    import com.game.transactions.control.*;
    import com.game.transactions.message.*;
    import net.*;

    public class ResTransactionsSetStateHandler extends Handler
    {

        public function ResTransactionsSetStateHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTransactionsSetStateMessage(this.message);
            TransactionControl.getInstance().setStateRes(_loc_1.playerid, _loc_1.state);
            return;
        }// end function

    }
}
