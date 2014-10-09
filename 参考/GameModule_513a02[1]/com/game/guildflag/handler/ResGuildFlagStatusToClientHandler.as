package com.game.guildflag.handler
{
    import com.game.guildflag.message.*;
    import net.*;

    public class ResGuildFlagStatusToClientHandler extends Handler
    {

        public function ResGuildFlagStatusToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildFlagStatusToClientMessage(this.message);
            return;
        }// end function

    }
}
