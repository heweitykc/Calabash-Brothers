package com.game.epalace.handler
{
    import com.game.epalace.message.*;
    import net.*;

    public class ResEpalaceRewardInfoToClientHandler extends Handler
    {

        public function ResEpalaceRewardInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResEpalaceRewardInfoToClientMessage(this.message);
            return;
        }// end function

    }
}
