package com.game.store.handler
{
    import com.game.store.control.*;
    import com.game.store.message.*;
    import net.*;

    public class ResStoreItemAddHandler extends Handler
    {

        public function ResStoreItemAddHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStoreItemAddMessage(this.message);
            StoreControl.getInstance().storeItemAddBack(_loc_1);
            return;
        }// end function

    }
}
