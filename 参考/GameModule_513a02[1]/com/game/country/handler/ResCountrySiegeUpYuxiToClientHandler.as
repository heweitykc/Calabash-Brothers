package com.game.country.handler
{
    import com.game.country.control.*;
    import com.game.country.message.*;
    import net.*;

    public class ResCountrySiegeUpYuxiToClientHandler extends Handler
    {

        public function ResCountrySiegeUpYuxiToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCountrySiegeUpYuxiToClientMessage(this.message);
            CountryControl.getInstance().resCountrySiegeUpYuxiHandler(_loc_1);
            return;
        }// end function

    }
}
