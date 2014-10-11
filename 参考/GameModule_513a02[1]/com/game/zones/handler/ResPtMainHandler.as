package com.game.zones.handler
{
    import com.game.zones.message.*;
    import net.*;

    public class ResPtMainHandler extends Handler
    {

        public function ResPtMainHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPtMainMessage(this.message);
            return;
        }// end function

    }
}
