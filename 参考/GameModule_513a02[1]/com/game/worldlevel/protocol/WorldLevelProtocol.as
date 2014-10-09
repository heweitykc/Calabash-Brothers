package com.game.worldlevel.protocol
{
    import com.*;
    import com.game.worldlevel.message.*;

    public class WorldLevelProtocol extends BaseProtocol
    {

        public function WorldLevelProtocol()
        {
            return;
        }// end function

        public function reqWorldLevelInfo() : void
        {
            var _loc_1:* = new ReqWorldLevelInfoMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
