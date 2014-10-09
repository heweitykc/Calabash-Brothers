package com.game.friend.handler
{
    import com.game.friend.message.*;
    import net.*;

    public class ResRelationAddOrChangeToClientHandler extends Handler
    {

        public function ResRelationAddOrChangeToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRelationAddOrChangeToClientMessage(this.message);
            return;
        }// end function

    }
}
