package com.game.mail.message
{
    import net.*;

    public class ResMailGetNewMailToClientMessage extends Message
    {
        private var _nCount:int;

        public function ResMailGetNewMailToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._nCount);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._nCount = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 124110;
        }// end function

        public function get nCount() : int
        {
            return this._nCount;
        }// end function

        public function set nCount(param1:int) : void
        {
            this._nCount = param1;
            return;
        }// end function

    }
}
