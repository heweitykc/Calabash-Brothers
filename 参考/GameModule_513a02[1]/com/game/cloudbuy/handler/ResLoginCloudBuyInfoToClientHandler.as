package com.game.cloudbuy.handler
{
    import com.game.cloudbuy.control.*;
    import com.game.cloudbuy.message.*;
    import net.*;

    public class ResLoginCloudBuyInfoToClientHandler extends Handler
    {

        public function ResLoginCloudBuyInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResLoginCloudBuyInfoToClientMessage(this.message);
            CloudBuyControl.getInstance().resLoginCloudBuyInfoHandler(_loc_1);
            return;
        }// end function

    }
}
