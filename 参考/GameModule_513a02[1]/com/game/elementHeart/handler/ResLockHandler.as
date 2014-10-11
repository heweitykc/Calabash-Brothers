package com.game.elementHeart.handler
{
    import com.game.elementHeart.control.*;
    import com.game.masterequip.message.*;
    import net.*;

    public class ResLockHandler extends Handler
    {

        public function ResLockHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResLockMessage(this.message);
            ElementHeartControl.getInstance().updateLock(_loc_1);
            return;
        }// end function

    }
}
