package com.game.redfortress.handler
{
    import com.game.redfortress.control.*;
    import com.game.redfortress.message.*;
    import net.*;

    public class ResCsysTopListHandler extends Handler
    {

        public function ResCsysTopListHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCsysTopListMessage(this.message);
            ZonesRedFortressControl.getInstance().resCsysTopListHandler(_loc_1);
            return;
        }// end function

    }
}
