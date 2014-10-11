package com.game.elementHeart.handler
{
    import com.game.elementHeart.control.*;
    import com.game.masterequip.message.*;
    import net.*;

    public class ResRemoveHandler extends Handler
    {

        public function ResRemoveHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRemoveMessage(this.message);
            ElementHeartControl.getInstance().resRemove(_loc_1.type, _loc_1.index);
            return;
        }// end function

    }
}
