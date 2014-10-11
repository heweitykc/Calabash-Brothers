package com.game.scripts.handler
{
    import com.game.scripts.message.*;
    import net.*;

    public class ResShowPaneleInfoToClientHandler extends Handler
    {

        public function ResShowPaneleInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResShowPaneleInfoToClientMessage(this.message);
            return;
        }// end function

    }
}
