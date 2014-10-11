package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildDeleteInfoRoundToClientHandler extends Handler
    {

        public function ResGuildDeleteInfoRoundToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildDeleteInfoRoundToClientMessage(this.message);
            GuildControl.getInstance().resGuildDeleteInfoRoundHandler(_loc_1);
            return;
        }// end function

    }
}
