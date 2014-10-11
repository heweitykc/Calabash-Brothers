package com.game.transactions.handler
{
    import com.game.transactions.control.*;
    import com.game.transactions.message.*;
    import net.*;

    public class ResTransactionsChangeGoldHandler extends Handler
    {

        public function ResTransactionsChangeGoldHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTransactionsChangeGoldMessage(this.message);
            TransactionControl.getInstance().changeMoneyRes(_loc_1.playerid, _loc_1.gold);
            return;
        }// end function

    }
}
