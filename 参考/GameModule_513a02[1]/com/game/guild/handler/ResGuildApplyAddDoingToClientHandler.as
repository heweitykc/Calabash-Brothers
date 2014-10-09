package com.game.guild.handler
{
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildApplyAddDoingToClientHandler extends Handler
    {

        public function ResGuildApplyAddDoingToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildApplyAddDoingToClientMessage(this.message);
            GuildControl.getInstance().resGuildApplyAddDoingHandler(_loc_1);
            return;
        }// end function

    }
}
