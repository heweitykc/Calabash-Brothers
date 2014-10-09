package com.game.task.handler
{
    import com.game.task.control.*;
    import com.game.task.message.*;
    import net.*;

    public class ResTaskRewardInBagHandler extends Handler
    {

        public function ResTaskRewardInBagHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTaskRewardInBagMessage(this.message);
            TaskControl.getInstance().showGetReward(_loc_1);
            return;
        }// end function

    }
}
