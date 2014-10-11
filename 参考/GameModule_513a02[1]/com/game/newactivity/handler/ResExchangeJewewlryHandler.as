package com.game.newactivity.handler
{
    import com.game.newactivity.mayactivity.control.*;
    import com.game.newactivity.message.*;
    import net.*;

    public class ResExchangeJewewlryHandler extends Handler
    {

        public function ResExchangeJewewlryHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResExchangeJewewlryMessage(this.message);
            MayControl.getInstance().resExchangeJewewlryHandler(_loc_1);
            return;
        }// end function

    }
}
