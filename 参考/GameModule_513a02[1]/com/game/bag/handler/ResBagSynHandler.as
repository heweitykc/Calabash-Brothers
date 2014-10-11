package com.game.bag.handler
{
    import com.game.bag.message.*;
    import net.*;

    public class ResBagSynHandler extends Handler
    {

        public function ResBagSynHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBagSynMessage(this.message);
            return;
        }// end function

    }
}
