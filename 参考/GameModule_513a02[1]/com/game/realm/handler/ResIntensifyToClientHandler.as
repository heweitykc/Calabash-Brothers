package com.game.realm.handler
{
    import com.game.realm.message.*;
    import net.*;

    public class ResIntensifyToClientHandler extends Handler
    {

        public function ResIntensifyToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResIntensifyToClientMessage(this.message);
            return;
        }// end function

    }
}
