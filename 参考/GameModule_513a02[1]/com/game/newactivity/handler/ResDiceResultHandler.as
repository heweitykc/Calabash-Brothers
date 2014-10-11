package com.game.newactivity.handler
{
    import com.game.bocake.message.*;
    import com.game.newactivity.moonFestival.control.*;
    import net.*;

    public class ResDiceResultHandler extends Handler
    {

        public function ResDiceResultHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResOpenBoCakeInfoToClientMessage(this.message);
            MoonFestivalControl.getInstance().doDiceResult(_loc_1);
            return;
        }// end function

    }
}
