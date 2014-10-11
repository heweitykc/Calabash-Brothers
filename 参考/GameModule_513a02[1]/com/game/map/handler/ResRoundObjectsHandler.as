package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResRoundObjectsHandler extends Handler
    {

        public function ResRoundObjectsHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundObjectsMessage(this.message);
            MapControl.getInstance().roundObjectsHandler(_loc_1);
            return;
        }// end function

    }
}
