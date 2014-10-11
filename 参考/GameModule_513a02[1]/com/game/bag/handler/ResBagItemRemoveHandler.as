package com.game.bag.handler
{
    import com.game.bag.message.*;
    import net.*;

    public class ResBagItemRemoveHandler extends Handler
    {

        public function ResBagItemRemoveHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBagItemRemoveMessage(this.message);
            return;
        }// end function

    }
}
