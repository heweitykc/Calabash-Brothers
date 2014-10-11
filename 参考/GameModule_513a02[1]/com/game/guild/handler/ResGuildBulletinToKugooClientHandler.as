package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildBulletinToKugooClientHandler extends Handler
    {

        public function ResGuildBulletinToKugooClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildBulletinToKugooClientMessage(this.message);
            GuildControl.getInstance().kugouGuildInfoChange(_loc_1);
            return;
        }// end function

    }
}
