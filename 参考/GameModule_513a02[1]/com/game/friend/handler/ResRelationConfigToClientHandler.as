package com.game.friend.handler
{
    import com.game.friend.message.*;
    import net.*;

    public class ResRelationConfigToClientHandler extends Handler
    {

        public function ResRelationConfigToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRelationConfigToClientMessage(this.message);
            return;
        }// end function

    }
}
