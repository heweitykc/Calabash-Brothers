package com.game.greedisland.protocol
{
    import com.*;
    import com.game.zones.message.*;

    public class IslandProtocol extends BaseProtocol
    {

        public function IslandProtocol()
        {
            return;
        }// end function

        public function reqIslandGoldCombo() : void
        {
            var _loc_1:* = new ReqAddBuffMessage();
            _loc_1.type = 0;
            send(_loc_1);
            return;
        }// end function

    }
}
