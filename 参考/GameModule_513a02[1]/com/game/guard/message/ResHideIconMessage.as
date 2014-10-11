package com.game.guard.message
{
    import net.*;

    public class ResHideIconMessage extends Message
    {

        public function ResHideIconMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600016;
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
