package com.game.primaryrole.protocol
{
    import com.*;
    import com.game.player.message.*;

    public class PrimaryRoleProtocol extends BaseProtocol
    {

        public function PrimaryRoleProtocol()
        {
            return;
        }// end function

        public function addPoint(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = new ReqAddPointMessage();
            _loc_5.agile = param1;
            _loc_5.vitality = param2;
            _loc_5.intelligence = param3;
            _loc_5.strength = param4;
            send(_loc_5);
            return;
        }// end function

    }
}
