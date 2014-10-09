package com.game.bag.handler
{
    import com.game.bag.message.*;
    import net.*;

    public class ResBagItemAddHandler extends Handler
    {

        public function ResBagItemAddHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBagItemAddMessage(this.message);
            return;
        }// end function

    }
}
