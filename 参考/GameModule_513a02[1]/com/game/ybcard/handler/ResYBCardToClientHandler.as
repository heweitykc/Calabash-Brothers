package com.game.ybcard.handler
{
    import com.game.ybcard.message.*;
    import net.*;

    public class ResYBCardToClientHandler extends Handler
    {

        public function ResYBCardToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResYBCardToClientMessage(this.message);
            return;
        }// end function

    }
}
