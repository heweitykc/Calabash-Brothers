package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildAloneMemberInfoToClientHandler extends Handler
    {

        public function ResGuildAloneMemberInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildAloneMemberInfoToClientMessage(this.message);
            GuildControl.getInstance().resAloneMemberInfoHandler(_loc_1);
            return;
        }// end function

    }
}
