package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResPlayerStopHandler extends Handler
    {

        public function ResPlayerStopHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerStopMessage(this.message);
            MapControl.getInstance().roleStopHandler(_loc_1.personId, _loc_1.position, _loc_1.mapModelId);
            return;
        }// end function

    }
}
