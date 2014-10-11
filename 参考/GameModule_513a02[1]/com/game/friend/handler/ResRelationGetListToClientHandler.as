package com.game.friend.handler
{
    import com.game.friend.message.*;
    import net.*;

    public class ResRelationGetListToClientHandler extends Handler
    {

        public function ResRelationGetListToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRelationGetListToClientMessage(this.message);
            return;
        }// end function

    }
}
