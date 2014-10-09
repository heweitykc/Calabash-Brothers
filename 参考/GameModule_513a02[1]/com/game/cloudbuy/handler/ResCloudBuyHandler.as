package com.game.cloudbuy.handler
{
    import com.game.cloudbuy.control.*;
    import com.game.cloudbuy.message.*;
    import net.*;

    public class ResCloudBuyHandler extends Handler
    {

        public function ResCloudBuyHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCloudBuyToClientMessage(this.message);
            CloudBuyControl.getInstance().resCloudBuyHandler(_loc_1);
            return;
        }// end function

    }
}
