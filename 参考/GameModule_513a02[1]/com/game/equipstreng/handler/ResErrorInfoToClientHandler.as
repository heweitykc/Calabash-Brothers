package com.game.equipstreng.handler
{
    import com.game.equipstreng.message.*;
    import net.*;

    public class ResErrorInfoToClientHandler extends Handler
    {

        public function ResErrorInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResErrorInfoToClientMessage(this.message);
            return;
        }// end function

    }
}
