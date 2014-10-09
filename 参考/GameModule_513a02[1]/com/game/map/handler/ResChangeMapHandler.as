package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResChangeMapHandler extends Handler
    {

        public function ResChangeMapHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChangeMapMessage(this.message);
            MapControl.getInstance().changeMapHandler(_loc_1);
            return;
        }// end function

    }
}
