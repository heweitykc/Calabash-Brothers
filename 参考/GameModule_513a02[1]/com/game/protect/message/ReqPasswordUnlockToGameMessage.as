package com.game.protect.message
{
    import net.*;

    public class ReqPasswordUnlockToGameMessage extends Message
    {
        public var password:String;

        public function ReqPasswordUnlockToGameMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 164204;
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
