package com.game.prey.handler
{
    import com.game.pray.message.*;
    import com.game.prey.control.*;
    import net.*;

    public class ResPrayInfoHandler extends Handler
    {

        public function ResPrayInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPrayInfoMessage(this.message);
            PrayControl.getInstance().setPrayInfo(_loc_1.prayInfo);
            return;
        }// end function

    }
}
