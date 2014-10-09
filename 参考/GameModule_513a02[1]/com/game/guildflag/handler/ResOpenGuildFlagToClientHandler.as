package com.game.guildflag.handler
{
    import com.game.guildflag.message.*;
    import net.*;

    public class ResOpenGuildFlagToClientHandler extends Handler
    {

        public function ResOpenGuildFlagToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResOpenGuildFlagToClientMessage(this.message);
            return;
        }// end function

    }
}
