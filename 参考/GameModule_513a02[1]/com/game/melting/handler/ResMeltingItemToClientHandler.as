package com.game.melting.handler
{
    import com.game.melting.message.*;
    import net.*;

    public class ResMeltingItemToClientHandler extends Handler
    {

        public function ResMeltingItemToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMeltingItemToClientMessage(this.message);
            return;
        }// end function

    }
}
