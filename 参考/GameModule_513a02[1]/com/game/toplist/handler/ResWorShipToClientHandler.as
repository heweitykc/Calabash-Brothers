package com.game.toplist.handler
{
    import com.game.toplist.message.*;
    import net.*;

    public class ResWorShipToClientHandler extends Handler
    {

        public function ResWorShipToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResWorShipToClientMessage(this.message);
            return;
        }// end function

    }
}
