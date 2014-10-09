package com.game.signwage.message
{
    import net.*;

    public class ReqFillSignMessage extends Message
    {
        private var _date:int;

        public function ReqFillSignMessage()
        {
            return;
        }// end function

        public function set date(param1:int) : void
        {
            this._date = param1;
            return;
        }// end function

        public function get date() : int
        {
            return this._date;
        }// end function

        override public function getId() : int
        {
            return 601000;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._date);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._date = readInt();
            return true;
        }// end function

    }
}
