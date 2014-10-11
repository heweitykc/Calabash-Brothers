package com.game.spirittree.handler
{
    import com.game.spirittree.message.*;
    import net.*;

    public class ResContinuousRipeningToClientHandler extends Handler
    {

        public function ResContinuousRipeningToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResContinuousRipeningToClientMessage(this.message);
            return;
        }// end function

    }
}
