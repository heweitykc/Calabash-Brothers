package com.game.chestbox.handler
{
    import com.game.chestbox.message.*;
    import net.*;

    public class ResChestBoxChooseInfoToClientHandler extends Handler
    {

        public function ResChestBoxChooseInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChestBoxChooseInfoToClientMessage(this.message);
            return;
        }// end function

    }
}
