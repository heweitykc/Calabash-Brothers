package com.game.setupmenu.handler
{
    import com.game.setupmenu.message.*;
    import net.*;

    public class ResMenuStatusHandler extends Handler
    {

        public function ResMenuStatusHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMenuStatusMessage(this.message);
            return;
        }// end function

    }
}
