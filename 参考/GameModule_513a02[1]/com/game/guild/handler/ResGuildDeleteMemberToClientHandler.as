package com.game.guild.handler
{
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildDeleteMemberToClientHandler extends Handler
    {

        public function ResGuildDeleteMemberToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildDeleteMemberToClientMessage(this.message);
            return;
        }// end function

    }
}
