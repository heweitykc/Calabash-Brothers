package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildGetGuildShortInfoListToClientHandler extends Handler
    {

        public function ResGuildGetGuildShortInfoListToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildGetGuildShortInfoListToClientMessage(this.message);
            GuildControl.getInstance().resGuildShortInfoHandler(_loc_1);
            return;
        }// end function

    }
}
