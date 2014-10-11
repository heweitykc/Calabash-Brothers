package com.game.chestbox.handler
{
    import com.game.chestbox.message.*;
    import net.*;

    public class ResChestBoxAutoSetToClientHandler extends Handler
    {

        public function ResChestBoxAutoSetToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChestBoxAutoSetToClientMessage(this.message);
            return;
        }// end function

    }
}
