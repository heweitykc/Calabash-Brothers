package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildChangeBannerIconToClientHandler extends Handler
    {

        public function ResGuildChangeBannerIconToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildChangeBannerIconToClientMessage(this.message);
            GuildControl.getInstance().resGuildChangeBannerIconHandler(_loc_1);
            return;
        }// end function

    }
}
