package com.game.rank.handler
{
    import com.game.rank.message.*;
    import net.*;

    public class ResRankUPToClientHandler extends Handler
    {

        public function ResRankUPToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRankUPToClientMessage(this.message);
            return;
        }// end function

    }
}
