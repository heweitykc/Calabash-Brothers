package com.game.realm.handler
{
    import com.game.realm.message.*;
    import net.*;

    public class ResRealmInfoToClientHandler extends Handler
    {

        public function ResRealmInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRealmInfoToClientMessage(this.message);
            return;
        }// end function

    }
}
