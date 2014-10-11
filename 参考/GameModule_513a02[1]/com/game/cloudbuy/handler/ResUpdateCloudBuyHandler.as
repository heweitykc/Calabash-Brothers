package com.game.cloudbuy.handler
{
    import com.game.cloudbuy.control.*;
    import com.game.cloudbuy.message.*;
    import net.*;

    public class ResUpdateCloudBuyHandler extends Handler
    {

        public function ResUpdateCloudBuyHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResUpdateCloudBuyToClientMessage(this.message);
            CloudBuyControl.getInstance().resUpdateCloudBuyHandler(_loc_1);
            return;
        }// end function

    }
}
