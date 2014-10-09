package com.game.team.handler
{
    import com.game.team.message.*;
    import net.*;

    public class ResAppointClientHandler extends Handler
    {

        public function ResAppointClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAppointClientMessage(this.message);
            return;
        }// end function

    }
}
