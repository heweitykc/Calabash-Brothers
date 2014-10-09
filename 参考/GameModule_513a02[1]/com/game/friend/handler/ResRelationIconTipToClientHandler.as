package com.game.friend.handler
{
    import com.game.friend.message.*;
    import net.*;

    public class ResRelationIconTipToClientHandler extends Handler
    {

        public function ResRelationIconTipToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRelationIconTipToClientMessage(this.message);
            return;
        }// end function

    }
}
