package com.game.vip.message
{
    import net.*;

    public class ResVIPExpiredMessage extends Message
    {

        public function ResVIPExpiredMessage()
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
            return 147104;
        }// end function

    }
}
