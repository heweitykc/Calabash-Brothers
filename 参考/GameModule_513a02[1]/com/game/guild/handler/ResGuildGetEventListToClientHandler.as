package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildGetEventListToClientHandler extends Handler
    {

        public function ResGuildGetEventListToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildGetEventListToClientMessage(this.message);
            GuildControl.getInstance().resGuildGetEventListHandler(_loc_1);
            return;
        }// end function

    }
}
