package com.game.npc.handler
{
    import com.game.npc.message.*;
    import com.game.player.control.*;
    import net.*;

    public class ResStopGatherHandler extends Handler
    {

        public function ResStopGatherHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStopGatherMessage(this.message);
            PlayerControl.getInstance().playerStopGatherHandler(_loc_1);
            return;
        }// end function

    }
}
