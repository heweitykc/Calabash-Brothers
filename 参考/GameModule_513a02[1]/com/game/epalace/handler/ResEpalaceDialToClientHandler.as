package com.game.epalace.handler
{
    import com.game.epalace.message.*;
    import net.*;

    public class ResEpalaceDialToClientHandler extends Handler
    {

        public function ResEpalaceDialToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResEpalaceDialToClientMessage(this.message);
            return;
        }// end function

    }
}
