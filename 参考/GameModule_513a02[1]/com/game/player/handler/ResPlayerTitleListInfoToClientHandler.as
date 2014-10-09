package com.game.player.handler
{
    import com.game.player.message.*;
    import com.model.*;
    import net.*;

    public class ResPlayerTitleListInfoToClientHandler extends Handler
    {

        public function ResPlayerTitleListInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerTitleListInfoToClientMessage(message);
            MyTitleData.instance.resetTitles();
            MyTitleData.instance.initMyTitles(_loc_1.ids, _loc_1.tms);
            return;
        }// end function

    }
}
