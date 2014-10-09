package com.game.toplist.handler
{
    import com.game.toplist.message.*;
    import net.*;

    public class ResGetTopTitleToClientHandler extends Handler
    {

        public function ResGetTopTitleToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGetTopTitleToClientMessage(this.message);
            return;
        }// end function

    }
}
