package com.game.stalls.handler
{
    import com.game.stalls.control.*;
    import com.game.stalls.message.*;
    import com.model.vo.*;
    import net.*;

    public class ResStallsAdjustPricesHandler extends Handler
    {

        public function ResStallsAdjustPricesHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStallsAdjustPricesMessage(this.message);
            var _loc_2:* = new StallsInfo();
            _loc_2.playerid = _loc_1.stallsinfo.playerid;
            _loc_2.playername = _loc_1.stallsinfo.playername;
            _loc_2.stallslv = _loc_1.stallsinfo.stallslv;
            _loc_2.stallsname = _loc_1.stallsinfo.stallsname;
            _loc_2.convGoods(_loc_1.stallsinfo.stallsgoodsinfo);
            StallsControl.getInstance().addjust(_loc_2);
            return;
        }// end function

    }
}
