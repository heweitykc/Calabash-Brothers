package com.game.player.message
{
    import net.*;

    public class ReqNonageTimeMessage extends Message
    {

        public function ReqNonageTimeMessage()
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
            return 103207;
        }// end function

    }
}
