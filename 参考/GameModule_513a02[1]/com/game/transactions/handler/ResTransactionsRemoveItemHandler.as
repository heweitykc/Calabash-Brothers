package com.game.transactions.handler
{
    import com.game.transactions.control.*;
    import com.game.transactions.message.*;
    import net.*;

    public class ResTransactionsRemoveItemHandler extends Handler
    {

        public function ResTransactionsRemoveItemHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTransactionsRemoveItemMessage(this.message);
            TransactionControl.getInstance().removeItemRes(_loc_1.playerid, _loc_1.itemid);
            return;
        }// end function

    }
}
