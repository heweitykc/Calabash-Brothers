package com.game.guild.handler
{
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildAddMemberToClientHandler extends Handler
    {

        public function ResGuildAddMemberToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildAddMemberToClientMessage(this.message);
            return;
        }// end function

    }
}
