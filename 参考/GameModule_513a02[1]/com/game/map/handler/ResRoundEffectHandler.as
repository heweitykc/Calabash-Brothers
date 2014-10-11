package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResRoundEffectHandler extends Handler
    {

        public function ResRoundEffectHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundEffectMessage(this.message);
            MapControl.getInstance().roundEffect(_loc_1);
            return;
        }// end function

    }
}
