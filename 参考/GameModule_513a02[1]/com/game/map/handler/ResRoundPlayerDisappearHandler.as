package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResRoundPlayerDisappearHandler extends Handler
    {

        public function ResRoundPlayerDisappearHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundPlayerDisappearMessage(this.message);
            MapControl.getInstance().roundObjectDisappearHandler(_loc_1.playerIds);
            return;
        }// end function

    }
}
