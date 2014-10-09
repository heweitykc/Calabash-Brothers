package com.game.biwudao.handler
{
    import com.game.biwudao.message.*;
    import net.*;

    public class ResBiWuInfoToClientHandler extends Handler
    {

        public function ResBiWuInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBiWuInfoToClientMessage(this.message);
            return;
        }// end function

    }
}
