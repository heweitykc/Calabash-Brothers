package com.game.biwudao.handler
{
    import com.game.biwudao.message.*;
    import net.*;

    public class ResBiWuDaoFlagCoolDownToClientHandler extends Handler
    {

        public function ResBiWuDaoFlagCoolDownToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBiWuDaoFlagCoolDownToClientMessage(this.message);
            return;
        }// end function

    }
}
