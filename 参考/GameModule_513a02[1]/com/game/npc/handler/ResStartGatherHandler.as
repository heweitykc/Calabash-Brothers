package com.game.npc.handler
{
    import com.game.gather.control.*;
    import com.game.npc.message.*;
    import net.*;

    public class ResStartGatherHandler extends Handler
    {

        public function ResStartGatherHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStartGatherMessage(this.message);
            GatherController.getInstance().gatherTaskStartHandle(_loc_1);
            return;
        }// end function

    }
}
