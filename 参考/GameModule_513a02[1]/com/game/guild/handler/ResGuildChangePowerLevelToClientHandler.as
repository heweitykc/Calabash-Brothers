package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildChangePowerLevelToClientHandler extends Handler
    {

        public function ResGuildChangePowerLevelToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildChangePowerLevelToClientMessage(this.message);
            GuildControl.getInstance().resGuildChangePowerLevelHandler(_loc_1);
            return;
        }// end function

    }
}
