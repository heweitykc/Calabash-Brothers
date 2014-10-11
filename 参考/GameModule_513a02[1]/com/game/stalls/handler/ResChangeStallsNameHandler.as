package com.game.stalls.handler
{
    import com.game.stalls.control.*;
    import com.game.stalls.message.*;
    import net.*;

    public class ResChangeStallsNameHandler extends Handler
    {

        public function ResChangeStallsNameHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChangeStallsNameMessage(this.message);
            if (_loc_1.status == 0)
            {
                StallsControl.getInstance().changeTitleRes(_loc_1.name);
            }
            return;
        }// end function

    }
}
