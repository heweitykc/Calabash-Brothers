package com.game.backpack.handler
{
    import com.game.backpack.control.*;
    import com.game.backpack.message.*;
    import com.game.backpack.model.*;
    import net.*;

    public class ResCellTimeHandler extends Handler
    {

        public function ResCellTimeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCellTimeMessage(this.message);
            BackpackObj.getInstance().info.openningGridId = _loc_1.cellId;
            BackpackObj.getInstance().info.cellTime = _loc_1.timeRemaining;
            BackPackControl.getInstance().addCD();
            BackPackControl.getInstance().openItemChange();
            BackPackControl.getInstance().cellTimeRes();
            return;
        }// end function

    }
}
