package com.game.mail.message
{
    import net.*;

    public class ReqMailQueryListToServerMessage extends Message
    {

        public function ReqMailQueryListToServerMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 124151;
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
