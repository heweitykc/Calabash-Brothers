package com.game.goldRaffle.handler
{
    import com.game.goldRaffle.control.*;
    import com.game.goldRaffle.message.*;
    import net.*;

    public class ResOpenGoldRaffleInfoToClientHandler extends Handler
    {

        public function ResOpenGoldRaffleInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = null;
            _loc_1 = ResOpenGoldRaffleInfoToClientMessage(this.message);
            var _loc_2:* = GoldRaffleControl.getInstance();
            _loc_2.updateFraction(_loc_1.fraction);
            _loc_2.lotteryTicket = _loc_1.coupon;
            _loc_2.chestsCapacity = _loc_1.capacity;
            _loc_2.loglist = _loc_1.goldRaffleEventInfoList;
            _loc_2.updateGoldRafflesPanel();
            return;
        }// end function

    }
}
