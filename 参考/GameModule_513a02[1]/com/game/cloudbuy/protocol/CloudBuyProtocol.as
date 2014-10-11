package com.game.cloudbuy.protocol
{
    import com.*;
    import com.game.cloudbuy.message.*;

    public class CloudBuyProtocol extends BaseProtocol
    {

        public function CloudBuyProtocol()
        {
            return;
        }// end function

        public function reqOpenCloudBuyInfo() : void
        {
            var _loc_1:* = new ReqOpenCloudBuyInfoToServerMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqCloudBuy(param1:int) : void
        {
            var _loc_2:* = new ReqCloudBuyToServerMessage();
            _loc_2.count = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqCloudBuyReward() : void
        {
            var _loc_1:* = new ReqCloudBuyRewardToServerMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
