package com.game.magicbook.message
{
    import net.*;

    public class ResAdvancedUpMessage extends Message
    {
        private var _result:int;

        public function ResAdvancedUpMessage()
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
            return 600037;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._result);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._result = readInt();
            return true;
        }// end function

    }
}
