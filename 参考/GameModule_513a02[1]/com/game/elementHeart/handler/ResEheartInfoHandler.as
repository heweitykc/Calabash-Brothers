package com.game.elementHeart.handler
{
    import com.game.elementHeart.control.*;
    import com.game.masterequip.message.*;
    import net.*;

    public class ResEheartInfoHandler extends Handler
    {

        public function ResEheartInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResEheartInfoMessage(this.message);
            ElementHeartControl.getInstance().resEheartInfo(_loc_1.type, _loc_1.info);
            return;
        }// end function

    }
}
