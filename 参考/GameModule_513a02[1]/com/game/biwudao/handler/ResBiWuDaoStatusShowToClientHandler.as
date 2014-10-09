package com.game.biwudao.handler
{
    import com.game.biwudao.message.*;
    import net.*;

    public class ResBiWuDaoStatusShowToClientHandler extends Handler
    {

        public function ResBiWuDaoStatusShowToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBiWuDaoStatusShowToClientMessage(this.message);
            return;
        }// end function

    }
}
