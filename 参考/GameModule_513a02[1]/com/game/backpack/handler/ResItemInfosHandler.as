package com.game.backpack.handler
{
    import com.game.backpack.control.*;
    import com.game.backpack.message.*;
    import com.game.backpack.model.*;
    import net.*;

    public class ResItemInfosHandler extends Handler
    {

        public function ResItemInfosHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResItemInfosMessage(this.message);
            BackpackObj.getInstance().info.data = _loc_1.items;
            BackpackObj.getInstance().info.cellNum = _loc_1.cellnum;
            BackPackControl.getInstance().updateBox();
            return;
        }// end function

    }
}
