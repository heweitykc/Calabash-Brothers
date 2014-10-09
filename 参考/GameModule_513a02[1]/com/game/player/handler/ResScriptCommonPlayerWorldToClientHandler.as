package com.game.player.handler
{
    import com.game.player.message.*;
    import net.*;

    public class ResScriptCommonPlayerWorldToClientHandler extends Handler
    {

        public function ResScriptCommonPlayerWorldToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResScriptCommonPlayerWorldToClientMessage(this.message);
            return;
        }// end function

    }
}
