package com.game.guild.handler
{
    import com.game.guild.message.*;
    import net.*;

    public class ResGuildChangeBulletinToClientHandler extends Handler
    {

        public function ResGuildChangeBulletinToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGuildChangeBulletinToClientMessage(this.message);
            return;
        }// end function

    }
}
