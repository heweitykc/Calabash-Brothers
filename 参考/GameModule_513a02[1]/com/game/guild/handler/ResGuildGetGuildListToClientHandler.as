package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildGetGuildListToClientHandler extends Handler
    {

        public function ResGuildGetGuildListToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildGetGuildListToClientMessage(this.message);
            GuildControl.getInstance().resGuildListHandler(_loc_1);
            return;
        }// end function

    }
}
