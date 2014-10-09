package com.game.country.handler
{
    import com.game.country.control.*;
    import com.game.country.message.*;
    import net.*;

    public class ResCountrySiegeYuXiImmediateToClientHandler extends Handler
    {

        public function ResCountrySiegeYuXiImmediateToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCountrySiegeYuXiImmediateToClientMessage(this.message);
            CountryControl.getInstance().resCountrySiegeYuXiImmediateHandler(_loc_1);
            return;
        }// end function

    }
}
