package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResEnterMapHandler extends Handler
    {

        public function ResEnterMapHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResEnterMapMessage(this.message);
            MapControl.getInstance().enterMapHandler(_loc_1);
            return;
        }// end function

    }
}
