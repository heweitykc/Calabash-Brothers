package com.game.bag.handler
{
    import com.game.bag.message.*;
    import net.*;

    public class ResBagItemUpdateHandler extends Handler
    {

        public function ResBagItemUpdateHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBagItemUpdateMessage(this.message);
            return;
        }// end function

    }
}
