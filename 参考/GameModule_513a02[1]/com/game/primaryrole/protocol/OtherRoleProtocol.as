package com.game.primaryrole.protocol
{
    import com.*;
    import com.game.player.message.*;
    import com.game.utils.*;

    public class OtherRoleProtocol extends BaseProtocol
    {

        public function OtherRoleProtocol()
        {
            return;
        }// end function

        public function reqOtherPlayerInfo(param1:long, param2:int) : void
        {
            var _loc_3:* = new ReqOtherPlayerInfoMessage();
            _loc_3.personId = param1;
            _loc_3.type = param2;
            send(_loc_3);
            return;
        }// end function

    }
}
