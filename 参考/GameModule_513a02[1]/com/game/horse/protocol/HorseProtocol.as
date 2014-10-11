package com.game.horse.protocol
{
    import com.*;
    import com.game.horse.message.*;

    public class HorseProtocol extends BaseProtocol
    {

        public function HorseProtocol()
        {
            return;
        }// end function

        public function reqChangeRidingState(param1:int, param2:int) : void
        {
            var _loc_3:* = new ReqChangeRidingStateMessage();
            _loc_3.status = param1;
            _loc_3.curlayer = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqGetHorseInfo() : void
        {
            var _loc_1:* = new ReqGethorseInfoMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqHorseStageUpStartMessage(param1:int) : void
        {
            var _loc_2:* = new ReqhorseStageUpStartMessage();
            _loc_2.type = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqHorseReceive() : void
        {
            var _loc_1:* = new ReqhorseReceiveMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
