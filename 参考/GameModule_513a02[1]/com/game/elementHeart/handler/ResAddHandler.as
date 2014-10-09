package com.game.elementHeart.handler
{
    import com.game.elementHeart.control.*;
    import com.game.masterequip.message.*;
    import net.*;

    public class ResAddHandler extends Handler
    {

        public function ResAddHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAddMessage(this.message);
            ElementHeartControl.getInstance().resAdd(_loc_1);
            return;
        }// end function

    }
}
