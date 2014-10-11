package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResSetPositionHandler extends Handler
    {

        public function ResSetPositionHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSetPositionMessage(this.message);
            MapControl.getInstance().setPositionHandler(_loc_1);
            return;
        }// end function

    }
}
