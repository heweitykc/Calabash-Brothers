package com.game.casting.handler
{
    import com.game.casting.control.*;
    import com.game.casting.message.*;
    import net.*;

    public class ResCastingDecomposeToClientHandler extends Handler
    {

        public function ResCastingDecomposeToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCastingDecomposeToClientMessage(this.message);
            var _loc_2:* = ZhuZaoControl.getInstance();
            _loc_2.technologyPoint = _loc_1.technologyPoint;
            _loc_2.showDecomposeFlash(_loc_1.itemList, _loc_1.technologyPointList);
            super.action();
            return;
        }// end function

    }
}
