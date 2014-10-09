package com.game.guild.handler
{
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildQuitToClientHandler extends Handler
    {

        public function ResGuildQuitToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildQuitToClientMessage(this.message);
            return;
        }// end function

    }
}
