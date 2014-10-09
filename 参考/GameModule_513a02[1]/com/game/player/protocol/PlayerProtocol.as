package com.game.player.protocol
{
    import com.*;
    import com.game.player.message.*;

    public class PlayerProtocol extends BaseProtocol
    {

        public function PlayerProtocol()
        {
            return;
        }// end function

        public function revive() : void
        {
            var _loc_1:* = new ReqReviveMessage();
            send(_loc_1);
            return;
        }// end function

        public function localRevive(param1:int, param2:int) : void
        {
            var _loc_3:* = new ReqLocalReviveMessage();
            _loc_3.itemmodelid = param1;
            _loc_3.type = param2;
            send(_loc_3);
            return;
        }// end function

        public function checkNopage() : void
        {
            var _loc_1:* = new ReqNonageTimeMessage();
            send(_loc_1);
            return;
        }// end function

        public function saveConfig(param1:int) : void
        {
            var _loc_2:* = new ReqClientConfigToServerMessage();
            _loc_2.value = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqFinishThreeChangeJob() : void
        {
            var _loc_1:* = new ReqFinishThreeChangeJobMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
