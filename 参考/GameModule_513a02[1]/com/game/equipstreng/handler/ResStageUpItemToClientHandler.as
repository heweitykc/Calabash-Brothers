package com.game.equipstreng.handler
{
    import com.game.equipstreng.message.*;
    import net.*;

    public class ResStageUpItemToClientHandler extends Handler
    {

        public function ResStageUpItemToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStageUpItemToClientMessage(this.message);
            return;
        }// end function

    }
}
