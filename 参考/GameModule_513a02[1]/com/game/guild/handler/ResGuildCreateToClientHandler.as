package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildCreateToClientHandler extends Handler
    {

        public function ResGuildCreateToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildCreateToClientMessage(this.message);
            GuildControl.getInstance().resCreateGuildHandler(_loc_1);
            return;
        }// end function

    }
}
