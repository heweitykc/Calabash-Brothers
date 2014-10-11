package com.game.chestbox.handler
{
    import com.game.chestbox.message.*;
    import net.*;

    public class ResChestBoxNewGridInfoToClientHandler extends Handler
    {

        public function ResChestBoxNewGridInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChestBoxNewGridInfoToClientMessage(this.message);
            return;
        }// end function

    }
}
