package com.game.biwudao.handler
{
    import com.game.biwudao.message.*;
    import net.*;

    public class ResBiWuDaoTotalGainToClientHandler extends Handler
    {

        public function ResBiWuDaoTotalGainToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBiWuDaoTotalGainToClientMessage(this.message);
            return;
        }// end function

    }
}
