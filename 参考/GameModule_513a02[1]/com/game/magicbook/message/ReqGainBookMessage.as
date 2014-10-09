package com.game.magicbook.message
{
    import net.*;

    public class ReqGainBookMessage extends Message
    {

        public function ReqGainBookMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600215;
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
