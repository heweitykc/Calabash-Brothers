package com.game.primaryrole.protocol
{
    import com.*;
    import com.game.player.message.*;

    public class TitleProtocol extends BaseProtocol
    {

        public function TitleProtocol()
        {
            return;
        }// end function

        public function wearTitle(param1:int) : void
        {
            var _loc_2:* = new ReqWearTitleToServerMessage();
            _loc_2.titleId = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
