package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResMapBossInfoHandler extends Handler
    {

        public function ResMapBossInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMapBossInfoMessage(this.message);
            MapControl.getInstance().showBossReliveItem(_loc_1);
            return;
        }// end function

    }
}
