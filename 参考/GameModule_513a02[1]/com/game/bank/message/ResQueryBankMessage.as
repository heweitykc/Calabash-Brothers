package com.game.bank.message
{
    import net.*;

    public class ResQueryBankMessage extends Message
    {
        private var _buyLv:int;
        private var _nums:String;
        private var _curryday:int;

        public function ResQueryBankMessage()
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

        public function set nums(param1:String) : void
        {
            this._nums = param1;
            return;
        }// end function

        public function get nums() : String
        {
            return this._nums;
        }// end function

        public function set curryday(param1:int) : void
        {
            this._curryday = param1;
            return;
        }// end function

        public function get curryday() : int
        {
            return this._curryday;
        }// end function

        override public function getId() : int
        {
            return 510200;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._buyLv);
            writeString(this._nums);
            writeInt(this._curryday);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._buyLv = readInt();
            this._nums = readString();
            this._curryday = readInt();
            return true;
        }// end function

    }
}
