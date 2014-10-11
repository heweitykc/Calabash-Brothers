package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResRoundNpcHandler extends Handler
    {

        public function ResRoundNpcHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundNpcMessage(this.message);
            MapControl.getInstance().roundNpcShowHandler(_loc_1);
            return;
        }// end function

    }
}
