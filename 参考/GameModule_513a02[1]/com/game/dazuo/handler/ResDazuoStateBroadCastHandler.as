package com.game.dazuo.handler
{
    import com.game.dazuo.message.*;
    import net.*;

    public class ResDazuoStateBroadCastHandler extends Handler
    {

        public function ResDazuoStateBroadCastHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResDazuoStateBroadCastMessage(this.message);
            return;
        }// end function

    }
}
