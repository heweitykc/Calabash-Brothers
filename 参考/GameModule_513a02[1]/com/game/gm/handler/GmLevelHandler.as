package com.game.gm.handler
{
    import com.game.gm.message.*;
    import net.*;

    public class GmLevelHandler extends Handler
    {

        public function GmLevelHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = GmLevelMessage(this.message);
            return;
        }// end function

    }
}
