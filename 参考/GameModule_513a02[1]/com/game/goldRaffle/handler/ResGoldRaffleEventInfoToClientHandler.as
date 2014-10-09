package com.game.goldRaffle.handler
{
    import __AS3__.vec.*;
    import com.game.goldRaffle.control.*;
    import com.game.goldRaffle.message.*;
    import net.*;

    public class ResGoldRaffleEventInfoToClientHandler extends Handler
    {

        public function ResGoldRaffleEventInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGoldRaffleEventInfoToClientMessage(this.message);
            var _loc_2:* = _loc_1.goldRaffleEventInfoList;
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                GoldRaffleControl.getInstance().addLogEvent(_loc_2[_loc_4]);
                _loc_4++;
            }
            GoldRaffleControl.getInstance().updateGoldRafflesPanel();
            return;
        }// end function

    }
}
