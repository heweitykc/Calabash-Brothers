package com.game.protect.message
{
    import net.*;

    public class ReqVerificationMessage extends Message
    {
        public var sessionId:int;
        public var passwd:String;

        public function ReqVerificationMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 164203;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this.sessionId);
            writeString(this.passwd);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

    }
}
