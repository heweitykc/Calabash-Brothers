package com.game.guild.handler
{
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildDeleteDiplomaticToClientHandler extends Handler
    {

        public function ResGuildDeleteDiplomaticToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildDeleteDiplomaticToClientMessage(this.message);
            return;
        }// end function

    }
}
