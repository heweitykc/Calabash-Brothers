package com.game.bank.handler
{
    import com.game.bank.control.*;
    import com.game.bank.message.*;
    import net.*;

    public class ResQueryBankMessageToClientHandler extends Handler
    {

        public function ResQueryBankMessageToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResQueryBankMessage(this.message);
            BankControl.getInstance().resQueryBankHandler(_loc_1);
            return;
        }// end function

    }
}
