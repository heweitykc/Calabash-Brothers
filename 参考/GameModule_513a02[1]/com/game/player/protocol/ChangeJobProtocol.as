package com.game.player.protocol
{
    import com.*;
    import com.game.player.message.*;

    public class ChangeJobProtocol extends BaseProtocol
    {

        public function ChangeJobProtocol()
        {
            return;
        }// end function

        public function reqMasterChangeState() : void
        {
            var _loc_1:* = new ReqGetActivatedStarInfo();
            send(_loc_1);
            return;
        }// end function

        public function reqActivateStar() : void
        {
            var _loc_1:* = new ReqActivateStar();
            send(_loc_1);
            return;
        }// end function

    }
}
