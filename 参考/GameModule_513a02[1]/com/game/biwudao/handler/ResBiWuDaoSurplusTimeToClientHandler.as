package com.game.biwudao.handler
{
    import com.game.biwudao.message.*;
    import net.*;

    public class ResBiWuDaoSurplusTimeToClientHandler extends Handler
    {

        public function ResBiWuDaoSurplusTimeToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBiWuDaoSurplusTimeToClientMessage(this.message);
            return;
        }// end function

    }
}
