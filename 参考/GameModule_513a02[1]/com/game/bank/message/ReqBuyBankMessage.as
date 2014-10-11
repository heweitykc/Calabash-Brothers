package com.game.bank.message
{
    import net.*;

    public class ReqBuyBankMessage extends Message
    {
        private var _buyLv:int;

        public function ReqBuyBankMessage()
        {
            return;
        }// end function

        public function set buyLv(param1:int) : void
        {
            this._buyLv = param1;
            return;
        }// end function

        public function get buyLv() : int
        {
            return this._buyLv;
        }// end function

        override public function getId() : int
        {
            return 510203;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._buyLv);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._buyLv = readInt();
            return true;
        }// end function

    }
}
