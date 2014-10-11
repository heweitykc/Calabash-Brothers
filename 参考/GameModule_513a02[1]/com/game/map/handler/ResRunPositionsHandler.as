package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResRunPositionsHandler extends Handler
    {

        public function ResRunPositionsHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRunPositionsMessage(this.message);
            MapControl.getInstance().runPositionsHandler(_loc_1);
            return;
        }// end function

    }
}
