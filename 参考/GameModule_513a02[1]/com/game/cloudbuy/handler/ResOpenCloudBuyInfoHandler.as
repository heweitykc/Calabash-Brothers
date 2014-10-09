package com.game.cloudbuy.handler
{
    import com.game.cloudbuy.control.*;
    import com.game.cloudbuy.message.*;
    import net.*;

    public class ResOpenCloudBuyInfoHandler extends Handler
    {

        public function ResOpenCloudBuyInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResOpenCloudBuyInfoToClientMessage(this.message);
            CloudBuyControl.getInstance().resOpenCloudBuyInfoHandler(_loc_1);
            return;
        }// end function

    }
}
