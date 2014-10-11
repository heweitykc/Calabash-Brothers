package com.game.redfortress.handler
{
    import com.game.redfortress.control.*;
    import com.game.redfortress.message.*;
    import net.*;

    public class ResEnterActivitieHandler extends Handler
    {

        public function ResEnterActivitieHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResEnterActivitieMessage(this.message);
            ZonesRedFortressControl.getInstance().resEnterActivate(_loc_1);
            return;
        }// end function

    }
}
