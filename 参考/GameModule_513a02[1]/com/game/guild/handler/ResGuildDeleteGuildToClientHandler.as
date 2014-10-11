package com.game.guild.handler
{
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildDeleteGuildToClientHandler extends Handler
    {

        public function ResGuildDeleteGuildToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildDeleteGuildToClientMessage(this.message);
            return;
        }// end function

    }
}
