package com.game.country.handler
{
    import com.game.country.control.*;
    import com.game.country.message.*;
    import net.*;

    public class ResKingCityTimeRewardToClientHandler extends Handler
    {

        public function ResKingCityTimeRewardToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResKingCityTimeRewardToClientMessage(this.message);
            CountryControl.getInstance().resKingCityTimeRewardHandler(_loc_1);
            return;
        }// end function

    }
}
