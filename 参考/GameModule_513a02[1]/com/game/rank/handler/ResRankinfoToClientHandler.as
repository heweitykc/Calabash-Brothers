package com.game.rank.handler
{
    import com.game.rank.message.*;
    import net.*;

    public class ResRankinfoToClientHandler extends Handler
    {

        public function ResRankinfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRankinfoToClientMessage(this.message);
            return;
        }// end function

    }
}
