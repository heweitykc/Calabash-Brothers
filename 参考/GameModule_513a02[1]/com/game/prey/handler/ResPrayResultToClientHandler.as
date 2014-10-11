package com.game.prey.handler
{
    import com.game.pray.message.*;
    import com.game.prey.control.*;
    import net.*;

    public class ResPrayResultToClientHandler extends Handler
    {

        public function ResPrayResultToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPrayResultToClientMessage(this.message);
            PrayControl.getInstance().prayResult(_loc_1.type, _loc_1.isSuccess == 1);
            super.action();
            return;
        }// end function

    }
}
