package com.game.country.handler
{
    import com.game.country.control.*;
    import com.game.country.message.*;
    import net.*;

    public class ResCountrySiegeWarStateToClientHandler extends Handler
    {

        public function ResCountrySiegeWarStateToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCountrySiegeWarStateToClientMessage(this.message);
            CountryControl.getInstance().resCountrySiegeWarStateHandler(_loc_1);
            return;
        }// end function

    }
}
