package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResSetSpecialPositionHandler extends Handler
    {

        public function ResSetSpecialPositionHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSetSpecialPositionMessage(this.message);
            MapControl.getInstance().setSpecialPositionHandler(_loc_1);
            return;
        }// end function

    }
}
