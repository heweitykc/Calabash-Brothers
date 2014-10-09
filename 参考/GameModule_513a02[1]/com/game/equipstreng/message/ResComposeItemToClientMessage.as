package com.game.equipstreng.message
{
    import net.*;

    public class ResComposeItemToClientMessage extends Message
    {
        private var _issuccess:int;

        public function ResComposeItemToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._issuccess);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._issuccess = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103894;
        }// end function

        public function get issuccess() : int
        {
            return this._issuccess;
        }// end function

        public function set issuccess(param1:int) : void
        {
            this._issuccess = param1;
            return;
        }// end function

    }
}
