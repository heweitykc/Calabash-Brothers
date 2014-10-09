package com.game.goldRaffle.handler
{
    import com.game.goldRaffle.control.*;
    import com.game.goldRaffle.message.*;
    import com.game.prompt.utils.*;
    import net.*;

    public class ResFractionToClientHandler extends Handler
    {

        public function ResFractionToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResFractionToClientMessage(this.message);
            GoldRaffleControl.getInstance().updateFraction(_loc_1.fractionId);
            if (_loc_1.itemID != -1)
            {
                ItemGetAnim.doFlyGetItemToBack(_loc_1.itemID);
            }
            return;
        }// end function

    }
}
