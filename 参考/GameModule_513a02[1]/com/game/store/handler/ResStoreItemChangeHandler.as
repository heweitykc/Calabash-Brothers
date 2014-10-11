package com.game.store.handler
{
    import com.game.store.control.*;
    import com.game.store.message.*;
    import net.*;

    public class ResStoreItemChangeHandler extends Handler
    {

        public function ResStoreItemChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStoreItemChangeMessage(this.message);
            StoreControl.getInstance().storeItemChangeBack(_loc_1);
            return;
        }// end function

    }
}
