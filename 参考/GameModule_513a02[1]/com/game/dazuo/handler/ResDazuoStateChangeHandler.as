package com.game.dazuo.handler
{
    import com.game.dazuo.message.*;
    import net.*;

    public class ResDazuoStateChangeHandler extends Handler
    {

        public function ResDazuoStateChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResDazuoStateChangeMessage(this.message);
            return;
        }// end function

    }
}
