package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResChangePositionHandler extends Handler
    {

        public function ResChangePositionHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChangePositionMessage(this.message);
            MapControl.getInstance().changePositionHandler(_loc_1);
            return;
        }// end function

    }
}
