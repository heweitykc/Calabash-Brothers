package com.game.store.message
{
    import net.*;

    public class ResOpenStoreMessage extends Message
    {
        private var _result:uint;

        public function ResOpenStoreMessage()
        {
            return;
        }// end function

        override protected function reading() : Boolean
        {
            this._result = readByte();
            return true;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._result);
            return true;
        }// end function

        override public function getId() : int
        {
            return 112209;
        }// end function

        public function get result() : uint
        {
            return this._result;
        }// end function

        public function set result(param1:uint) : void
        {
            this._result = param1;
            return;
        }// end function

    }
}
