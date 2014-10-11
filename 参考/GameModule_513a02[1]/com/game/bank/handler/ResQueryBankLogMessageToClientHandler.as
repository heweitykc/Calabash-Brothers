package com.game.bank.handler
{
    import com.game.bank.control.*;
    import com.game.bank.message.*;
    import net.*;

    public class ResQueryBankLogMessageToClientHandler extends Handler
    {

        public function ResQueryBankLogMessageToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResQueryBankLogMessage(this.message);
            BankControl.getInstance().resQueryBankLogHandler(_loc_1);
            return;
        }// end function

    }
}
