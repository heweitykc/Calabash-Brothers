package com.game.store.handler
{
    import com.game.store.control.*;
    import com.game.store.message.*;
    import net.*;

    public class ResStoreOpenCellResultHandler extends Handler
    {

        public function ResStoreOpenCellResultHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStoreOpenCellResultMessage(this.message);
            StoreControl.getInstance().storeOpenCellResultBack(_loc_1);
            return;
        }// end function

    }
}
