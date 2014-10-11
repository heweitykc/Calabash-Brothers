package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResRoundEffectDisappearHandler extends Handler
    {

        public function ResRoundEffectDisappearHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundEffectDisappearMessage(this.message);
            MapControl.getInstance().roundEffectDisappear(_loc_1);
            return;
        }// end function

    }
}
