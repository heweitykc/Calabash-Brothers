package com.game.store.handler
{
    import com.game.store.control.*;
    import com.game.store.message.*;
    import net.*;

    public class ResOpenStoreHandler extends Handler
    {

        public function ResOpenStoreHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResOpenStoreMessage(this.message);
            StoreControl.getInstance().backOpenStore(_loc_1);
            return;
        }// end function

    }
}
