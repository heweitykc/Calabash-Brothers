package com.game.collect.handler
{
    import com.game.collect.message.*;
    import net.*;

    public class ResCollectInfoHandler extends Handler
    {

        public function ResCollectInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCollectInfoMessage(this.message);
            return;
        }// end function

    }
}
