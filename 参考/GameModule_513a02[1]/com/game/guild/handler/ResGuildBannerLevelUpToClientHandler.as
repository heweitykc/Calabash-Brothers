package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildBannerLevelUpToClientHandler extends Handler
    {

        public function ResGuildBannerLevelUpToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildBannerLevelUpToClientMessage(this.message);
            GuildControl.getInstance().resGuildBannerLevelUpHandler(_loc_1);
            return;
        }// end function

    }
}
