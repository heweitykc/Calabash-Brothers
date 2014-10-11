package com.game.cloudbuy.handler
{
    import com.game.cloudbuy.control.*;
    import com.game.cloudbuy.message.*;
    import net.*;

    public class ResRewardToClientHandler extends Handler
    {

        public function ResRewardToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRewardToClientMessage(this.message);
            CloudBuyControl.getInstance().resRewardHandler(_loc_1);
            return;
        }// end function

    }
}
