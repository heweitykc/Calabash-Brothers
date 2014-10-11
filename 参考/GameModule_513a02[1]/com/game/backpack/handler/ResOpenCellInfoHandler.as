package com.game.backpack.handler
{
    import com.game.backpack.message.*;
    import net.*;

    public class ResOpenCellInfoHandler extends Handler
    {

        public function ResOpenCellInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResOpenCellInfoMessage(this.message);
            return;
        }// end function

    }
}
