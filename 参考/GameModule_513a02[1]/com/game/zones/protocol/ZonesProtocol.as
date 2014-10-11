package com.game.zones.protocol
{
    import com.*;
    import com.game.zones.message.*;

    public class ZonesProtocol extends BaseProtocol
    {

        public function ZonesProtocol()
        {
            return;
        }// end function

        public function reqSelectAward(param1:int, param2:int) : void
        {
            var _loc_3:* = new ReqSelectAwardMessage();
            _loc_3.idx = param1;
            _loc_3.type = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqZoneAutoAwardToGame() : void
        {
            var _loc_1:* = new ReqZoneAutoAwardToGameMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqZoneCancelSignupToGame(param1:int, param2:int) : void
        {
            var _loc_3:* = new ReqZoneCancelSignupToGameMessage();
            _loc_3.type = param1;
            _loc_3.zoneid = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqZoneContinuousRaids() : void
        {
            var _loc_1:* = new ReqZoneContinuousRaidsMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqZoneContinuousRaidsStop() : void
        {
            var _loc_1:* = new ReqZoneContinuousRaidsStopMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqZoneContinuousRaidsYB() : void
        {
            var _loc_1:* = new ReqZoneContinuousRaidsYBMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqZoneImmediatelyByCost(param1:int) : void
        {
            var _loc_2:* = new ReqZoneImmediatelyByCostMessage();
            _loc_2.zoneid = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqZoneImmediately(param1:int) : void
        {
            var _loc_2:* = new ReqZoneImmediatelyMessage();
            _loc_2.type = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqZoneInto(param1:int, param2:int) : void
        {
            var _loc_3:* = new ReqZoneIntoMessage();
            _loc_3.isauto = param1;
            _loc_3.zoneid = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqZoneOpenPanel() : void
        {
            var _loc_1:* = new ReqZoneOpenPanelMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqZoneOut() : void
        {
            var _loc_1:* = new ReqZoneOutMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqZonePanelSelect(param1:int) : void
        {
            var _loc_2:* = new ReqZonePanelSelectMessage();
            _loc_2.zoneid = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqZoneReceiveawards(param1:int, param2:int) : void
        {
            var _loc_3:* = new ReqZoneReceiveawardsMessage();
            _loc_3.type = param1;
            _loc_3.zid = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqZoneTeamEnterToGame(param1:int, param2:int) : void
        {
            var _loc_3:* = new ReqZoneTeamEnterToGameMessage();
            _loc_3.entertype = param1;
            _loc_3.zoneid = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqZoneTeamOpenToGame(param1:int) : void
        {
            var _loc_2:* = new ReqZoneTeamOpenToGameMessage();
            _loc_2.zoneid = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqZoneTeamSelectToGame(param1:int, param2:int) : void
        {
            var _loc_3:* = new ReqZoneTeamSelectToGameMessage();
            _loc_3.select = param1;
            _loc_3.zoneid = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqAddInspireBuff(param1:int) : void
        {
            var _loc_2:* = new ReqAddBuffMessage();
            _loc_2.type = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqClearZoneCD(param1:int) : void
        {
            var _loc_2:* = new ReqClearZoneCDMessage();
            _loc_2.zoneid = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqChangeClientZone(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = new ReqInventedZoneMessage();
            _loc_4.zoneid = param1;
            _loc_4.type = param2;
            _loc_4.zoneid = param3;
            send(_loc_4);
            return;
        }// end function

        public function reqTowerIndex() : void
        {
            var _loc_1:* = new ReqTowerIndexMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqTowerNextLv() : void
        {
            var _loc_1:* = new ReqTowerNextLvMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqTowerReward() : void
        {
            var _loc_1:* = new ReqTowerRewardMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
