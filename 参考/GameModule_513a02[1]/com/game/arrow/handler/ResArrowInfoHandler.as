package com.game.arrow.handler
{
    import com.game.arrow.message.*;
    import net.*;

    public class ResArrowInfoHandler extends Handler
    {

        public function ResArrowInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResArrowInfoMessage(this.message);
            return;
        }// end function

    }
}
