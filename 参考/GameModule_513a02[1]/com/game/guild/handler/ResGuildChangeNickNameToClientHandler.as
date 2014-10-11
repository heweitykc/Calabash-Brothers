package com.game.guild.handler
{
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildChangeNickNameToClientHandler extends Handler
    {

        public function ResGuildChangeNickNameToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildChangeNickNameToClientMessage(this.message);
            return;
        }// end function

    }
}
