package com.game.perfectInfo.protocol
{
    import com.*;
    import com.game.player.message.*;

    public class PerfectInfoProtocol extends BaseProtocol
    {

        public function PerfectInfoProtocol()
        {
            return;
        }// end function

        public function reqSubmitImproveData(param1:String, param2:String) : void
        {
            var _loc_3:* = new ReqSubmitImproveDataMessage();
            _loc_3.name = param1;
            _loc_3.idCard = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqCollectImproveReward() : void
        {
            var _loc_1:* = new ReqCollectImproveRewardMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
