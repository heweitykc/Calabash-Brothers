package com.game.map.handler
{
    import com.game.map.message.*;
    import net.*;

    public class ResStartBlockHandler extends Handler
    {

        public function ResStartBlockHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStartBlockMessage(this.message);
            return;
        }// end function

    }
}
