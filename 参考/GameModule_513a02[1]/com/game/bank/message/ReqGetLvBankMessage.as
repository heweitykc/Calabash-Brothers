package com.game.bank.message
{
    import net.*;

    public class ReqGetLvBankMessage extends Message
    {
        private var _lv:int;

        public function ReqGetLvBankMessage()
        {
            return;
        }// end function

        public function set lv(param1:int) : void
        {
            this._lv = param1;
            return;
        }// end function

        public function get lv() : int
        {
            return this._lv;
        }// end function

        override public function getId() : int
        {
            return 510204;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._lv);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._lv = readInt();
            return true;
        }// end function

    }
}
