package com.game.newactivity.message
{
    import net.*;

    public class ResExchangeJewewlryMessage extends Message
    {
        public var result:int;

        public function ResExchangeJewewlryMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this.result);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.result = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 511019;
        }// end function

    }
}
