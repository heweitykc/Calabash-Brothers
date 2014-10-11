package com.game.role.protocol
{
    import com.*;
    import com.game.npc.message.*;
    import com.game.utils.*;

    public class NpcProtocol extends BaseProtocol
    {

        public function NpcProtocol()
        {
            return;
        }// end function

        public function reqNpcServices(param1:long) : void
        {
            var _loc_2:* = new ReqNpcServicesMessage();
            _loc_2.npcId = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
