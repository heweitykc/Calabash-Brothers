package com.game.login.handler
{
    import com.game.login.control.*;
    import com.game.login.message.*;
    import net.*;

    public class ResCharacterInfosHandler extends Handler
    {

        public function ResCharacterInfosHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCharacterInfosMessage(this.message);
            RegistControl.getInstance().characterInfoHandler(_loc_1);
            return;
        }// end function

    }
}
