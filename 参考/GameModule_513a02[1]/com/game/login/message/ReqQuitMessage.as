package com.game.login.message
{
    import net.*;

    public class ReqQuitMessage extends Message
    {

        public function ReqQuitMessage()
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
            return 100205;
        }// end function

    }
}
