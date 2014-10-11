package com.game.version.handler
{
    import com.game.version.message.*;
    import net.*;

    public class ResVersionUpdateToClientHandler extends Handler
    {

        public function ResVersionUpdateToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResVersionUpdateToClientMessage(this.message);
            return;
        }// end function

    }
}
