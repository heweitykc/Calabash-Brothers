package com.game.country.handler
{
    import com.game.country.control.*;
    import com.game.country.message.*;
    import net.*;

    public class ResCountryStructureInfoToClientHandler extends Handler
    {

        public function ResCountryStructureInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCountryStructureInfoToClientMessage(this.message);
            CountryControl.getInstance().resCountryStructureInfoHandler(_loc_1);
            return;
        }// end function

    }
}
