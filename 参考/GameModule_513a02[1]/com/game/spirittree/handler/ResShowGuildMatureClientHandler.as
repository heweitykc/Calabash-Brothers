package com.game.spirittree.handler
{
    import com.game.spirittree.message.*;
    import net.*;

    public class ResShowGuildMatureClientHandler extends Handler
    {

        public function ResShowGuildMatureClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResShowGuildMatureClientMessage(this.message);
            return;
        }// end function

    }
}
