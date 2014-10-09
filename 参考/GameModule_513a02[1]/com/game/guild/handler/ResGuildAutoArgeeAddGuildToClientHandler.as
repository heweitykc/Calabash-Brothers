package com.game.guild.handler
{
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildAutoArgeeAddGuildToClientHandler extends Handler
    {

        public function ResGuildAutoArgeeAddGuildToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildAutoArgeeAddGuildToClientMessage(this.message);
            return;
        }// end function

    }
}
