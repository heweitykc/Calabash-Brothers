package com.game.goldRaffle.handler
{
    import com.game.goldRaffle.control.*;
    import com.game.goldRaffle.message.*;
    import net.*;

    public class ResGoldRaffleBoxUseItemToClientHandler extends Handler
    {

        public function ResGoldRaffleBoxUseItemToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGoldRaffleBoxUseItemToClientMessage(this.message);
            if (_loc_1.isSuccess == 1)
            {
                GoldRaffleControl.getInstance().removeReward(_loc_1.grididx, _loc_1.type);
            }
            return;
        }// end function

    }
}
