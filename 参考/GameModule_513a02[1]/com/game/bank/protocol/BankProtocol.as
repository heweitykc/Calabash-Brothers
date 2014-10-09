package com.game.bank.protocol
{
    import com.*;
    import com.game.bank.message.*;

    public class BankProtocol extends BaseProtocol
    {

        public function BankProtocol()
        {
            return;
        }// end function

        public function reqBuyBank(param1:int) : void
        {
            var _loc_2:* = new ReqBuyBankMessage();
            _loc_2.buyLv = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqGetMonthBank(param1:int) : void
        {
            var _loc_2:* = new ReqGetMonthBankMessage();
            _loc_2.type = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqQueryBank(param1:int) : void
        {
            var _loc_2:* = new ReqQueryBankMessage();
            _loc_2.type = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqGetLvBank(param1:int) : void
        {
            var _loc_2:* = new ReqGetLvBankMessage();
            _loc_2.lv = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqQueryBankLog(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = new ReqQueryBankLogMessage();
            _loc_4.option = param1;
            _loc_4.indexlittle = param2;
            _loc_4.indexLarge = param3;
            send(_loc_4);
            return;
        }// end function

    }
}
