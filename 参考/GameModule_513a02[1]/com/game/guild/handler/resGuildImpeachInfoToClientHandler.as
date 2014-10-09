package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class resGuildImpeachInfoToClientHandler extends Handler
    {

        public function resGuildImpeachInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildImpeachInfoToClientMessage(this.message);
            GuildControl.getInstance().resGuildImpeachInfoToClientHandler(_loc_1);
            return;
        }// end function

    }
}
