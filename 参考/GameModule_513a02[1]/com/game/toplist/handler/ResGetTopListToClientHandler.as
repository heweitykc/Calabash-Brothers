package com.game.toplist.handler
{
    import com.game.toplist.control.*;
    import com.game.toplist.message.*;
    import net.*;

    public class ResGetTopListToClientHandler extends Handler
    {

        public function ResGetTopListToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGetTopListToClientMessage(this.message);
            TopListControl.getInstance().updateByListInfo(_loc_1);
            return;
        }// end function

    }
}
