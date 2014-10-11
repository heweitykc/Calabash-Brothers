package com.game.signwage.handler
{
    import com.game.signwage.control.*;
    import com.game.signwage.message.*;
    import net.*;

    public class ResFillSignSucceedHandler extends Handler
    {

        public function ResFillSignSucceedHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResFillSignSucceedMessage(this.message);
            SignWageControl.getInstance().fillSignSuccessdMessage(_loc_1.date);
            return;
        }// end function

    }
}
