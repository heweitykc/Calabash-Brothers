package com.game.casting.handler
{
    import __AS3__.vec.*;
    import com.game.casting.control.*;
    import com.game.casting.message.*;
    import net.*;

    public class ResCastingOpenToClientHandler extends Handler
    {

        public function ResCastingOpenToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCastingOpenToClientMessage(this.message);
            var _loc_2:* = ZhuZaoControl.getInstance();
            _loc_2.technologyPoint = _loc_1.technologyPoint;
            var _loc_3:* = _loc_1.castingBoxInfo.castingGridInfoList;
            var _loc_4:* = _loc_3.length;
            var _loc_5:* = new Array(ZhuZaoControl.MAX_GRID_NUM);
            var _loc_6:* = 0;
            while (_loc_6 < _loc_4)
            {
                
                _loc_5[_loc_3[_loc_6].grididx] = _loc_3[_loc_6];
                _loc_6++;
            }
            _loc_2.gridInfos = _loc_5;
            super.action();
            return;
        }// end function

    }
}
