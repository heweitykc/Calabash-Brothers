package com.game.plugset.handler
{
    import com.game.plugset.message.*;
    import net.*;

    public class ResPlugSetInfoHandler extends Handler
    {

        public function ResPlugSetInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlugSetInfoMessage(this.message);
            return;
        }// end function

    }
}
