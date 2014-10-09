package com.game.backpack.message
{
    import net.*;

    public class ResMoneyChangeMessage extends Message
    {
        private var _money:int;

        public function ResMoneyChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._money);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._money = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 104105;
        }// end function

        public function get money() : int
        {
            return this._money;
        }// end function

        public function set money(param1:int) : void
        {
            this._money = param1;
            return;
        }// end function

    }
}
