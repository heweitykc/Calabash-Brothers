package com.game.epalace.handler
{
    import com.game.epalace.message.*;
    import net.*;

    public class ResEpalaceWalkToClientHandler extends Handler
    {

        public function ResEpalaceWalkToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResEpalaceWalkToClientMessage(this.message);
            return;
        }// end function

    }
}
