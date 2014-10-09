package com.game.backpack.handler
{
    import com.game.backpack.control.*;
    import com.game.backpack.message.*;
    import net.*;

    public class ResItemRemoveHandler extends Handler
    {

        public function ResItemRemoveHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResItemRemoveMessage(this.message);
            BackPackControl.getInstance().removeItemHandler(_loc_1);
            return;
        }// end function

    }
}
