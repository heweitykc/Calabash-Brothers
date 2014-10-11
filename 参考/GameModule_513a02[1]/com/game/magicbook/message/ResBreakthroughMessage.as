package com.game.magicbook.message
{
    import net.*;

    public class ResBreakthroughMessage extends Message
    {
        private var _result:int;

        public function ResBreakthroughMessage()
        {
            return;
        }// end function

        public function set result(param1:int) : void
        {
            this._result = param1;
            return;
        }// end function

        public function get result() : int
        {
            return this._result;
        }// end function

        override public function getId() : int
        {
            return 600031;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._result);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._result = readByte();
            return true;
        }// end function

    }
}
