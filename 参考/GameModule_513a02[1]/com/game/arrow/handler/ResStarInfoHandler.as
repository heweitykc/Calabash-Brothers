package com.game.arrow.handler
{
    import com.game.arrow.message.*;
    import net.*;

    public class ResStarInfoHandler extends Handler
    {

        public function ResStarInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStarInfoMessage(this.message);
            return;
        }// end function

    }
}
