package com.game.task.handler
{
    import com.game.task.control.*;
    import com.game.task.message.*;
    import net.*;

    public class ResTreasureHuntTaskChangeHandler extends Handler
    {

        public function ResTreasureHuntTaskChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTreasureHuntTaskChangeMessage(this.message);
            TaskControl.getInstance().resTreasureHuntTaskChangeHandler(_loc_1);
            return;
        }// end function

    }
}
