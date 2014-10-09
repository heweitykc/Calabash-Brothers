package com.game.player.handler
{
    import com.game.player.message.*;
    import net.*;

    public class ResAutoStartStateHandler extends Handler
    {

        public function ResAutoStartStateHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAutoStartStateMessage(this.message);
            return;
        }// end function

    }
}
