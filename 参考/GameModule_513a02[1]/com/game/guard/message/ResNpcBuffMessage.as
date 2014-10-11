package com.game.guard.message
{
    import net.*;

    public class ResNpcBuffMessage extends Message
    {

        public function ResNpcBuffMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600021;
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
