package com.game.rank.handler
{
    import com.game.rank.message.*;
    import net.*;

    public class ResRankExpToClientHandler extends Handler
    {

        public function ResRankExpToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRankExpToClientMessage(this.message);
            return;
        }// end function

    }
}
