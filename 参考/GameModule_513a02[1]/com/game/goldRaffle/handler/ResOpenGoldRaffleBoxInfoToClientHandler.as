package com.game.goldRaffle.handler
{
    import com.game.goldRaffle.control.*;
    import com.game.goldRaffle.message.*;
    import net.*;

    public class ResOpenGoldRaffleBoxInfoToClientHandler extends Handler
    {

        public function ResOpenGoldRaffleBoxInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = null;
            _loc_1 = ResOpenGoldRaffleBoxInfoToClientMessage(this.message);
            var _loc_2:* = GoldRaffleControl.getInstance();
            _loc_2.chestsCapacity = _loc_1.goldRaffleBoxInfo.goldRaffleGridList.length;
            _loc_2.updateChestsCapacity();
            _loc_2.rewardslist = _loc_1.goldRaffleBoxInfo.goldRaffleGridList;
            _loc_2.updateTreasureHousePanel();
            return;
        }// end function

    }
}
