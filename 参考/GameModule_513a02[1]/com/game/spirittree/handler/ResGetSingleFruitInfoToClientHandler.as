package com.game.spirittree.handler
{
    import com.game.spirittree.message.*;
    import net.*;

    public class ResGetSingleFruitInfoToClientHandler extends Handler
    {

        public function ResGetSingleFruitInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGetSingleFruitInfoToClientMessage(this.message);
            return;
        }// end function

    }
}
