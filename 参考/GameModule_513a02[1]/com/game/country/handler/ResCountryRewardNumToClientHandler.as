package com.game.country.handler
{
    import com.game.country.control.*;
    import com.game.country.message.*;
    import net.*;

    public class ResCountryRewardNumToClientHandler extends Handler
    {

        public function ResCountryRewardNumToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAwardInfoToClientMessage(this.message);
            CountryControl.getInstance().resCountryRewardNumHandler(_loc_1);
            return;
        }// end function

    }
}
