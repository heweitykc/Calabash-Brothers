package com.game.toplist.handler
{
    import com.game.toplist.message.*;
    import net.*;

    public class ResTopListChestInfoToClientHandler extends Handler
    {

        public function ResTopListChestInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTopListChestInfoToClientMessage(this.message);
            return;
        }// end function

    }
}
