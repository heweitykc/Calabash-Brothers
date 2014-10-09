package com.game.store.handler
{
    import com.game.store.control.*;
    import com.game.store.message.*;
    import net.*;

    public class ResStoreItemRemoveHandler extends Handler
    {

        public function ResStoreItemRemoveHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStoreItemRemoveMessage(this.message);
            StoreControl.getInstance().storeItemRemoveBack(_loc_1);
            return;
        }// end function

    }
}
