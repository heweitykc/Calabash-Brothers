package com.game.guild.handler
{
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildAddDiplomaticToClientHandler extends Handler
    {

        public function ResGuildAddDiplomaticToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildAddDiplomaticToClientMessage(this.message);
            return;
        }// end function

    }
}
