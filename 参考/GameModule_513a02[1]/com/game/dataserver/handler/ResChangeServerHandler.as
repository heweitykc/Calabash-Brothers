package com.game.dataserver.handler
{
    import com.game.dataserver.message.*;
    import net.*;

    public class ResChangeServerHandler extends Handler
    {

        public function ResChangeServerHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChangeServerMessage(this.message);
            return;
        }// end function

    }
}
