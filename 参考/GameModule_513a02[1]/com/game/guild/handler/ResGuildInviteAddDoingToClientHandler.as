package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildInviteAddDoingToClientHandler extends Handler
    {

        public function ResGuildInviteAddDoingToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildInviteAddDoingToClientMessage(this.message);
            GuildControl.getInstance().resGuildInviteAddDoingHandler(_loc_1);
            return;
        }// end function

    }
}
