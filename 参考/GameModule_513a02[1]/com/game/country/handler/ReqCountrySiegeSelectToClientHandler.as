package com.game.country.handler
{
    import com.game.country.control.*;
    import com.game.country.message.*;
    import net.*;

    public class ReqCountrySiegeSelectToClientHandler extends Handler
    {

        public function ReqCountrySiegeSelectToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ReqCountrySiegeSelectToClientMessage(this.message);
            CountryControl.getInstance().reqCountrySiegeSelectHandler(_loc_1);
            return;
        }// end function

    }
}
