package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildMemberListToKugooClientHandler extends Handler
    {

        public function ResGuildMemberListToKugooClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildMemberListToKugooClientMessage(this.message);
            GuildControl.getInstance().kugouGuildMemberListNotify(_loc_1);
            return;
        }// end function

    }
}
