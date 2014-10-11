package com.game.spirittree.handler
{
    import com.game.spirittree.message.*;
    import net.*;

    public class ResGetAllFruitInfoToClientHandler extends Handler
    {

        public function ResGetAllFruitInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGetAllFruitInfoToClientMessage(this.message);
            return;
        }// end function

    }
}
