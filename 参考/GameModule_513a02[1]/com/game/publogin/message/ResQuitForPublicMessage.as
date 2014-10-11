package com.game.publogin.message
{
    import net.*;

    public class ResQuitForPublicMessage extends Message
    {

        public function ResQuitForPublicMessage()
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
            return 204102;
        }// end function

    }
}
