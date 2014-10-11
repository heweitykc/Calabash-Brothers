package com.game.country.handler
{
    import com.game.country.control.*;
    import com.game.country.message.*;
    import net.*;

    public class ResCountryOverTopInfoToClientHandler extends Handler
    {

        public function ResCountryOverTopInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCountryOverTopInfoToClientMessage(this.message);
            CountryControl.getInstance().resCountryOverTopInfoHandler(_loc_1);
            return;
        }// end function

    }
}
