package com.game.goldRaffle.handler
{
    import com.game.goldRaffle.control.*;
    import com.game.goldRaffle.message.*;
    import net.*;

    public class ResGoldRaffleToClientHandler extends Handler
    {

        public function ResGoldRaffleToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = null;
            _loc_1 = ResGoldRaffleToClientMessage(this.message);
            var _loc_2:* = GoldRaffleControl.getInstance();
            _loc_2.rafflesExp = _loc_1.fraction;
            _loc_2.lotteryTicket = _loc_1.coupon;
            _loc_2.chestsCapacity = _loc_2.chestsCapacity + _loc_1.goldRaffleBoxInfo.goldRaffleGridList.length;
            _loc_2.addBoxes(_loc_1.goldRaffleBoxInfo);
            return;
        }// end function

    }
}
