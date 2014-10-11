package com.game.desktop
{
    import com.*;
    import com.game.player.message.*;

    public class DesktopProtocol extends BaseProtocol
    {

        public function DesktopProtocol()
        {
            return;
        }// end function

        public function reqCollectionReward() : void
        {
            var _loc_1:* = new ReqCollectionRewardMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
