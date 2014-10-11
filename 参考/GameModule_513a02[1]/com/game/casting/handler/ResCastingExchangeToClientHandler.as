package com.game.casting.handler
{
    import com.game.casting.control.*;
    import com.game.casting.message.*;
    import com.game.prompt.utils.*;
    import net.*;

    public class ResCastingExchangeToClientHandler extends Handler
    {

        public function ResCastingExchangeToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCastingExchangeToClientMessage(this.message);
            ZhuZaoControl.getInstance().technologyPoint = _loc_1.technologyPoint;
            ItemGetAnim.doFlyGetItemToBack(_loc_1.itemID);
            super.action();
            return;
        }// end function

    }
}
