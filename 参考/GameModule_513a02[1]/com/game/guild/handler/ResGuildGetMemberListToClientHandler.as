package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildGetMemberListToClientHandler extends Handler
    {

        public function ResGuildGetMemberListToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildGetMemberListToClientMessage(this.message);
            GuildControl.getInstance().resGuildMemberListHandler(_loc_1);
            return;
        }// end function

    }
}
