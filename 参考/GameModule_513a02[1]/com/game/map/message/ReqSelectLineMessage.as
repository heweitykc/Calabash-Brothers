package com.game.map.message
{
    import net.*;

    public class ReqSelectLineMessage extends Message
    {
        private var _line:int;

        public function ReqSelectLineMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._line);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._line = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 101212;
        }// end function

        public function get line() : int
        {
            return this._line;
        }// end function

        public function set line(param1:int) : void
        {
            this._line = param1;
            return;
        }// end function

    }
}
