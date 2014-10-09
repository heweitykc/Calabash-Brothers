package com.game.player.handler
{
    import com.game.map.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerNonageRegisterHandler extends Handler
    {

        public function ResPlayerNonageRegisterHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerNonageRegisterMessage(this.message);
            MapControl.getInstance().showOrHideAdult(_loc_1);
            return;
        }// end function

    }
}
