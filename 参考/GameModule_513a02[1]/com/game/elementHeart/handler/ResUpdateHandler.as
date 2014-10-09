package com.game.elementHeart.handler
{
    import com.game.elementHeart.control.*;
    import com.game.masterequip.message.*;
    import net.*;

    public class ResUpdateHandler extends Handler
    {

        public function ResUpdateHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResUpdateMessage(this.message);
            ElementHeartControl.getInstance().resUpdate(_loc_1);
            return;
        }// end function

    }
}
