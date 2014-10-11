package com.game.epalace.handler
{
    import com.game.epalace.message.*;
    import net.*;

    public class ResEpalaceDiceToClientHandler extends Handler
    {

        public function ResEpalaceDiceToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResEpalaceDiceToClientMessage(this.message);
            return;
        }// end function

    }
}
