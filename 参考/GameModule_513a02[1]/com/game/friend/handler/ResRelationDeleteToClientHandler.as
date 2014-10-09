package com.game.friend.handler
{
    import com.game.friend.message.*;
    import net.*;

    public class ResRelationDeleteToClientHandler extends Handler
    {

        public function ResRelationDeleteToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRelationDeleteToClientMessage(this.message);
            return;
        }// end function

    }
}
