package com.game.map.handler
{
    import com.game.map.message.*;
    import net.*;

    public class ResStopBlockHandler extends Handler
    {

        public function ResStopBlockHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStopBlockMessage(this.message);
            return;
        }// end function

    }
}
