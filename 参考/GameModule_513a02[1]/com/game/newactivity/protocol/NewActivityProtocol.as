package com.game.newactivity.protocol
{
    import com.*;
    import com.game.newactivity.message.*;
    import com.game.utils.*;

    public class NewActivityProtocol extends BaseProtocol
    {

        public function NewActivityProtocol()
        {
            return;
        }// end function

        public function getActivityInfo(param1:int) : void
        {
            var _loc_2:* = new ReqGetNewActivityInfo();
            _loc_2.activityId = param1;
            send(_loc_2);
            return;
        }// end function

        public function getActivityReward(param1:int, param2:int) : void
        {
            var _loc_3:* = new ReqGetNewActivityAward();
            _loc_3.activityId = param1;
            _loc_3.condiction = param2;
            send(_loc_3);
            return;
        }// end function

        public function getActivityRankInfo(param1:int) : void
        {
            var _loc_2:* = new ReqGetRankInfoMessage();
            _loc_2.activityId = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqExchangeJewewlry(param1:long, param2:long, param3:int) : void
        {
            var _loc_4:* = new ReqExchangeJewewlry();
            _loc_4._itemId1 = param1;
            _loc_4._itemId2 = param2;
            _loc_4.modelId = param3;
            send(_loc_4);
            return;
        }// end function

        public function reqOpenPainInfo() : void
        {
            var _loc_1:* = new ReqOpenPainMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
