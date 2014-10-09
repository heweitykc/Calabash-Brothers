package com.game.spirittree.handler
{
    import com.game.spirittree.message.*;
    import net.*;

    public class ResFruitErrorToClientHandler extends Handler
    {

        public function ResFruitErrorToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResFruitErrorToClientMessage(this.message);
            return;
        }// end function

    }
}
