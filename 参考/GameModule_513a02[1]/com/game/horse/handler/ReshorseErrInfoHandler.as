package com.game.horse.handler
{
    import com.game.horse.message.*;
    import net.*;

    public class ReshorseErrInfoHandler extends Handler
    {

        public function ReshorseErrInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ReshorseErrInfoMessage(this.message);
            return;
        }// end function

    }
}
