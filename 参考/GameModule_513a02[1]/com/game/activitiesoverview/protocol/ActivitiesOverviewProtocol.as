package com.game.activitiesoverview.protocol
{
    import com.*;
    import com.game.activitiesoverview.message.*;

    public class ActivitiesOverviewProtocol extends BaseProtocol
    {

        public function ActivitiesOverviewProtocol()
        {
            return;
        }// end function

        public function reqEvent() : void
        {
            var _loc_1:* = new ReqLivenessEventsToServerMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqBox() : void
        {
            var _loc_1:* = new ReqGainStateToServerMessage();
            send(_loc_1);
            return;
        }// end function

        public function gainBox(param1:int) : void
        {
            var _loc_2:* = new ReqGainBoxToServerMessage();
            _loc_2.boxId = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqliveness() : void
        {
            var _loc_1:* = new ReqLivenessToServerMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
