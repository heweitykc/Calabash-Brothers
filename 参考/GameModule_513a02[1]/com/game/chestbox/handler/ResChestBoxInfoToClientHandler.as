package com.game.chestbox.handler
{
    import com.game.chestbox.message.*;
    import net.*;

    public class ResChestBoxInfoToClientHandler extends Handler
    {

        public function ResChestBoxInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChestBoxInfoToClientMessage(this.message);
            return;
        }// end function

    }
}
