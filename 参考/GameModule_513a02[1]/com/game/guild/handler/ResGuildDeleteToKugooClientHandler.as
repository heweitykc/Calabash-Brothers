package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildDeleteToKugooClientHandler extends Handler
    {

        public function ResGuildDeleteToKugooClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildDeleteToKugooClientMessage(this.message);
            GuildControl.getInstance().kugouGuildDeleteNotify(_loc_1);
            return;
        }// end function

    }
}
