package com.game.scripts.handler
{
    import com.game.scripts.message.*;
    import net.*;

    public class ResPanelStatusInfoToClientHandler extends Handler
    {

        public function ResPanelStatusInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPanelStatusInfoToClientMessage(this.message);
            return;
        }// end function

    }
}
