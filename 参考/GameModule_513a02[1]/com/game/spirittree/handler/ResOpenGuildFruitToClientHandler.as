package com.game.spirittree.handler
{
    import com.game.spirittree.message.*;
    import net.*;

    public class ResOpenGuildFruitToClientHandler extends Handler
    {

        public function ResOpenGuildFruitToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResOpenGuildFruitToClientMessage(this.message);
            return;
        }// end function

    }
}
