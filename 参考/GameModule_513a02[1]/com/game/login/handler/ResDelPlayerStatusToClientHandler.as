﻿package com.game.login.handler
{
    import com.game.login.message.*;
    import net.*;

    public class ResDelPlayerStatusToClientHandler extends Handler
    {

        public function ResDelPlayerStatusToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResDelPlayerStatusToClientMessage(this.message);
            return;
        }// end function

    }
}
