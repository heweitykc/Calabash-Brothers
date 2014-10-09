package com.game.country.handler
{
    import com.game.country.message.*;
    import net.*;

    public class ResCountryArtilleryLocusToClientHandler extends Handler
    {

        public function ResCountryArtilleryLocusToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCountryArtilleryLocusToClientMessage(this.message);
            return;
        }// end function

    }
}
