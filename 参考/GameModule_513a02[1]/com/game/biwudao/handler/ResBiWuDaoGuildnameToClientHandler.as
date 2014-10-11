package com.game.biwudao.handler
{
    import com.game.biwudao.message.*;
    import net.*;

    public class ResBiWuDaoGuildnameToClientHandler extends Handler
    {

        public function ResBiWuDaoGuildnameToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBiWuDaoGuildnameToClientMessage(this.message);
            return;
        }// end function

    }
}
