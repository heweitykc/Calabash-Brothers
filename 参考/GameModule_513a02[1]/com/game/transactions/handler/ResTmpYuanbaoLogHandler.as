package com.game.transactions.handler
{
    import com.game.transactions.message.*;
    import net.*;

    public class ResTmpYuanbaoLogHandler extends Handler
    {

        public function ResTmpYuanbaoLogHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTmpYuanbaoLogMessage(this.message);
            return;
        }// end function

    }
}
