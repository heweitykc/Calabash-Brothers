package com.game.country.handler
{
    import com.game.country.control.*;
    import com.game.country.message.*;
    import net.*;

    public class ResKingCityChestSelectToClientHandler extends Handler
    {

        public function ResKingCityChestSelectToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResKingCityChestSelectToClientMessage(this.message);
            CountryControl.getInstance().resKingCityChestSelectHandler(_loc_1);
            return;
        }// end function

    }
}
