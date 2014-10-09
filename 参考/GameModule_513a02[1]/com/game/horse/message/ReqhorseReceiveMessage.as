package com.game.horse.message
{
    import net.*;

    public class ReqhorseReceiveMessage extends Message
    {

        public function ReqhorseReceiveMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

        override public function getId() : int
        {
            return 126207;
        }// end function

    }
}
