package com.game.transactions.protocol
{
    import com.*;
    import com.game.transactions.message.*;
    import com.game.utils.*;

    public class TransactionProtocol extends BaseProtocol
    {

        public function TransactionProtocol()
        {
            return;
        }// end function

        public function launchTransactions(param1:long) : void
        {
            var _loc_2:* = new ReqTransactionsLaunchMessage();
            _loc_2.playerid = param1;
            send(_loc_2);
            return;
        }// end function

        public function acceptTransactions(param1:long) : void
        {
            var _loc_2:* = new ReqTransactionsAcceptMessage();
            _loc_2.transid = param1;
            send(_loc_2);
            return;
        }// end function

        public function refuseTransactions(param1:long) : void
        {
            var _loc_2:* = new ReqTransactionsRefuseMessage();
            _loc_2.transid = param1;
            send(_loc_2);
            return;
        }// end function

        public function cancelTransactions() : void
        {
            var _loc_1:* = new ReqTransactionsCanceledMessage();
            send(_loc_1);
            return;
        }// end function

        public function insertItem(param1:int, param2:long) : void
        {
            var _loc_3:* = new ReqTransactionsIntoItemMessage();
            _loc_3.itemid = param2;
            _loc_3.itemposition = param1;
            send(_loc_3);
            return;
        }// end function

        public function removeItem(param1:long) : void
        {
            var _loc_2:* = new ReqTransactionsRemoveItemMessage();
            _loc_2.itemid = param1;
            send(_loc_2);
            return;
        }// end function

        public function goldChange(param1:int) : void
        {
            var _loc_2:* = new ReqTransactionsChangeGoldMessage();
            _loc_2.gold = param1;
            send(_loc_2);
            return;
        }// end function

        public function diamondChange(param1:int) : void
        {
            var _loc_2:* = new ReqTransactionsChangeYuanbaoMessage();
            _loc_2.yuanbao = param1;
            send(_loc_2);
            return;
        }// end function

        public function changeMoney(param1:int) : void
        {
            var _loc_2:* = new ReqTransactionsChangeGoldMessage();
            _loc_2.gold = param1;
            send(_loc_2);
            return;
        }// end function

        public function setState(param1:int) : void
        {
            var _loc_2:* = new ReqTransactionsSetStateMessage();
            _loc_2.state = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
