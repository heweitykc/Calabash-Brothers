package com.game.protect.message
{
    import net.*;

    public class ReqModifyPasswordToGameMessage extends Message
    {
        public var newpassword:String;
        public var oldpassword:String;

        public function ReqModifyPasswordToGameMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 164205;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this.newpassword);
            writeString(this.oldpassword);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

    }
}
