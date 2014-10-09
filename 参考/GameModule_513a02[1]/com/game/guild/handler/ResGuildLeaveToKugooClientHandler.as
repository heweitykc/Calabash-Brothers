package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildLeaveToKugooClientHandler extends Handler
    {

        public function ResGuildLeaveToKugooClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildLeaveToKugooClientMessage(message);
            GuildControl.getInstance().kugouGuildLeaveNotify(_loc_1);
            return;
        }// end function

    }
}
