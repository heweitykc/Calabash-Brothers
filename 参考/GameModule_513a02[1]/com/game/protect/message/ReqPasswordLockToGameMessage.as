package com.game.protect.message
{
    import net.*;

    public class ReqPasswordLockToGameMessage extends Message
    {
        public var password:String;

        public function ReqPasswordLockToGameMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 164201;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this.password);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

    }
}
