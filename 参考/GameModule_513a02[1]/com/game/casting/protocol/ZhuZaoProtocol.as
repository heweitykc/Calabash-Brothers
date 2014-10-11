package com.game.casting.protocol
{
    import com.*;
    import com.game.casting.message.*;

    public class ZhuZaoProtocol extends BaseProtocol
    {

        public function ZhuZaoProtocol()
        {
            return;
        }// end function

        public function reqCastingOpenToServer() : void
        {
            var _loc_1:* = new ReqCastingOpenToServerMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqCastingRewardToServer() : void
        {
            var _loc_1:* = new ReqCastingRewardToServerMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqCastingUseItemToServer(param1:int, param2:int) : void
        {
            var _loc_3:* = new ReqCastingUseItemToServerMessage();
            _loc_3.grididx = param1;
            _loc_3.type = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqCastingDecomposeToServer() : void
        {
            var _loc_1:* = new ReqCastingDecomposeToServerMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqCastingSellToServer() : void
        {
            var _loc_1:* = new ReqCastingSellToServerMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqCastingExchangeToServer(param1:int) : void
        {
            var _loc_2:* = new ReqCastingExchangeToServerMessage();
            _loc_2.exchangeID = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
