package com.game.realm.handler
{
    import com.game.realm.message.*;
    import net.*;

    public class ResRealmErrToClientHandler extends Handler
    {

        public function ResRealmErrToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRealmErrToClientMessage(this.message);
            return;
        }// end function

    }
}
