package com.game.country.handler
{
    import com.game.country.control.*;
    import com.game.country.message.*;
    import net.*;

    public class ResCountryTopInfoToClientHandler extends Handler
    {

        public function ResCountryTopInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCountryTopInfoToClientMessage(this.message);
            CountryControl.getInstance().resCountryTopInfoHandler(_loc_1);
            return;
        }// end function

    }
}
