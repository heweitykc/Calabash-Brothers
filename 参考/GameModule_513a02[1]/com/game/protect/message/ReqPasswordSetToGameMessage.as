package com.game.protect.message
{
    import net.*;

    public class ReqPasswordSetToGameMessage extends Message
    {
        public var password:String;
        public var mail:String;
        public var phone:String;

        public function ReqPasswordSetToGameMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 164202;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this.password);
            writeString(this.mail);
            writeString(this.phone);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

    }
}
