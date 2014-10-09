package com.game.transactions.handler
{
    import com.game.transactions.control.*;
    import com.game.transactions.message.*;
    import com.model.*;
    import net.*;

    public class ResTransactionsStartHandler extends Handler
    {

        public function ResTransactionsStartHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTransactionsStartMessage(this.message);
            if (_loc_1.arolemodeinfo.playerid.equal(UserObj.getInstance().playerInfo.personId))
            {
                TransactionControl.getInstance().openTransaction(_loc_1.brolemodeinfo.playerid, _loc_1.brolemodeinfo.playername, _loc_1.brolemodeinfo.playerlv);
            }
            else
            {
                TransactionControl.getInstance().openTransaction(_loc_1.arolemodeinfo.playerid, _loc_1.arolemodeinfo.playername, _loc_1.arolemodeinfo.playerlv);
            }
            return;
        }// end function

    }
}
