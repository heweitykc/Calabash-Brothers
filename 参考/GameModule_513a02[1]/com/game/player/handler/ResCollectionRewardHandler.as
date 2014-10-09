package com.game.player.handler
{
    import com.game.desktop.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResCollectionRewardHandler extends Handler
    {

        public function ResCollectionRewardHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCollectionRewardMessage(this.message);
            DesktopControl.getInsatnce().getAwards(_loc_1.itemlist);
            return;
        }// end function

    }
}
