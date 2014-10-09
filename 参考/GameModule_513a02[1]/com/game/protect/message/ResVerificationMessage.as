package com.game.protect.message
{
    import net.*;

    public class ResVerificationMessage extends Message
    {
        public var sessionId:int;
        public var result:int;

        public function ResVerificationMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 164103;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.sessionId = readInt();
            this.result = readInt();
            return true;
        }// end function

    }
}
