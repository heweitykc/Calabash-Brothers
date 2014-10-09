package com.game.transactions.message
{
    import net.*;

    public class ResCanreceiveYuanbaoMessage extends Message
    {
        private var _canryuanbao:int;

        public function ResCanreceiveYuanbaoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._canryuanbao);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._canryuanbao = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 122110;
        }// end function

        public function get canryuanbao() : int
        {
            return this._canryuanbao;
        }// end function

        public function set canryuanbao(param1:int) : void
        {
            this._canryuanbao = param1;
            return;
        }// end function

    }
}
