package com.game.guild.handler
{
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildSubmitItemToClientHandler extends Handler
    {

        public function ResGuildSubmitItemToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildSubmitItemToClientMessage(this.message);
            return;
        }// end function

    }
}
