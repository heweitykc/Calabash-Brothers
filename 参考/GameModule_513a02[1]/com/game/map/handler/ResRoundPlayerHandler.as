package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResRoundPlayerHandler extends Handler
    {

        public function ResRoundPlayerHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundPlayerMessage(this.message);
            MapControl.getInstance().roundPlayerShowHandler(_loc_1);
            return;
        }// end function

    }
}
