package com.game.team.handler
{
    import com.game.team.message.*;
    import net.*;

    public class ResGenericSearchToClientHandler extends Handler
    {

        public function ResGenericSearchToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGenericSearchToClientMessage(this.message);
            return;
        }// end function

    }
}
