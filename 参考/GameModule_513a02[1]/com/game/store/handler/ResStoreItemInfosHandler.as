package com.game.store.handler
{
    import com.game.store.control.*;
    import com.game.store.message.*;
    import net.*;

    public class ResStoreItemInfosHandler extends Handler
    {

        public function ResStoreItemInfosHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStoreItemInfosMessage(this.message);
            StoreControl.getInstance().storeItemInfosBack(_loc_1);
            return;
        }// end function

    }
}
