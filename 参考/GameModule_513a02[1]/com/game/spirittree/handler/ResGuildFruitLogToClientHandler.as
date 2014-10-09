package com.game.spirittree.handler
{
    import com.game.spirittree.message.*;
    import net.*;

    public class ResGuildFruitLogToClientHandler extends Handler
    {

        public function ResGuildFruitLogToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildFruitLogToClientMessage(this.message);
            return;
        }// end function

    }
}
