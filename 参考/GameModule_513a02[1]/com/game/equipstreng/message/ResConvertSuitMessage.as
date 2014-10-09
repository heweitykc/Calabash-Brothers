package com.game.equipstreng.message
{
    import net.*;

    public class ResConvertSuitMessage extends Message
    {
        public var result:int;

        public function ResConvertSuitMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 513001;
        }// end function

        override protected function reading() : Boolean
        {
            this.result = readByte();
            return true;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this.result);
            return true;
        }// end function

    }
}
