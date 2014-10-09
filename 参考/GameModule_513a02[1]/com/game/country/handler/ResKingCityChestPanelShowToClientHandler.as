package com.game.country.handler
{
    import com.game.country.control.*;
    import com.game.country.message.*;
    import net.*;

    public class ResKingCityChestPanelShowToClientHandler extends Handler
    {

        public function ResKingCityChestPanelShowToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResKingCityChestPanelShowToClientMessage(this.message);
            CountryControl.getInstance().resKingCityChestPanelShowHandler(_loc_1);
            return;
        }// end function

    }
}
