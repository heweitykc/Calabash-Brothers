package com.game.country.handler
{
    import com.game.country.message.*;
    import net.*;

    public class ResCountryWarCarDamageToClientHandler extends Handler
    {

        public function ResCountryWarCarDamageToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCountryWarCarDamageToClientMessage(this.message);
            return;
        }// end function

    }
}
