package com.game.gradegift.protocol
{
    import com.*;
    import com.game.gradegift.message.*;

    public class GradeGiftProtocol extends BaseProtocol
    {

        public function GradeGiftProtocol()
        {
            return;
        }// end function

        public function reqGainGift(param1:int) : void
        {
            var _loc_2:* = new ReqGainGradeGiftMessage();
            _loc_2.giftId = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
