package com.game.map.handler
{
    import com.game.map.message.*;
    import net.*;

    public class ResMapBlocksHandler extends Handler
    {

        public function ResMapBlocksHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMapBlocksMessage(this.message);
            return;
        }// end function

    }
}
