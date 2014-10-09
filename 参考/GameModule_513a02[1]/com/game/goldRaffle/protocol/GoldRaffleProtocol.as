package com.game.goldRaffle.protocol
{
    import com.*;
    import com.game.goldRaffle.message.*;

    public class GoldRaffleProtocol extends BaseProtocol
    {

        public function GoldRaffleProtocol()
        {
            return;
        }// end function

        public function reqGoldRaffleToServer(param1:int) : void
        {
            var _loc_2:* = new ReqGoldRaffleToServerMessage();
            _loc_2.type = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqOpenGoldRaffleBoxInfoToServer() : void
        {
            var _loc_1:* = new ReqOpenGoldRaffleBoxInfoToServerMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqFractionToServer(param1:int) : void
        {
            var _loc_2:* = new ReqFractionToServerMessage();
            _loc_2.fractionId = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqOpenRaffleInfoToServer() : void
        {
            var _loc_1:* = new ReqOpenRaffleInfoToServerMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqGoldRaffleBoxUseItemToServer(param1:int, param2:int) : void
        {
            var _loc_3:* = new ReqGoldRaffleBoxUseItemToServerMessage();
            _loc_3.grididx = param1;
            _loc_3.type = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqGoldRaffleBoxArrangeToServer() : void
        {
            var _loc_1:* = new ReqGoldRaffleBoxArrangeToServerMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
