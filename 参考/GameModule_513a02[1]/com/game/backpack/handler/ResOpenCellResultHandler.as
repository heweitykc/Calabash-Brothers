package com.game.backpack.handler
{
    import com.game.backpack.control.*;
    import com.game.backpack.message.*;
    import net.*;

    public class ResOpenCellResultHandler extends Handler
    {

        public function ResOpenCellResultHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResOpenCellResultMessage(this.message);
            if (_loc_1.isSuccess)
            {
                BackPackControl.getInstance().openCellRes(_loc_1.cellId);
            }
            return;
        }// end function

    }
}
