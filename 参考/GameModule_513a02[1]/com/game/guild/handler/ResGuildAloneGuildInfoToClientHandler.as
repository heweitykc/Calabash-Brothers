package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildAloneGuildInfoToClientHandler extends Handler
    {

        public function ResGuildAloneGuildInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildAloneGuildInfoToClientMessage(this.message);
            GuildControl.getInstance().resAloneGuildInfoHandler(_loc_1);
            return;
        }// end function

    }
}
