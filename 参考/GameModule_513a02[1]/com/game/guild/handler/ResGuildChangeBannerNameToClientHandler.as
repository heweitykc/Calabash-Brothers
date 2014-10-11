package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildChangeBannerNameToClientHandler extends Handler
    {

        public function ResGuildChangeBannerNameToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildChangeBannerNameToClientMessage(this.message);
            GuildControl.getInstance().resGuildChangeBannerNameHandler(_loc_1);
            return;
        }// end function

    }
}
