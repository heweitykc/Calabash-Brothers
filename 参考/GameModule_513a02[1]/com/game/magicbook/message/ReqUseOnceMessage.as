package com.game.magicbook.message
{
    import net.*;

    public class ReqUseOnceMessage extends Message
    {

        public function ReqUseOnceMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600212;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

    }
}
