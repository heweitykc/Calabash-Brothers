package com.game.store.handler
{
    import com.game.store.control.*;
    import com.game.store.message.*;
    import net.*;

    public class ResStoreCellTimeHandler extends Handler
    {

        public function ResStoreCellTimeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStoreCellTimeMessage(this.message);
            StoreControl.getInstance().storeCellTimeBack(_loc_1);
            return;
        }// end function

    }
}
