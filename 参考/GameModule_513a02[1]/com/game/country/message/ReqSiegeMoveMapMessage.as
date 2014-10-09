package com.game.country.message
{
    import net.*;

    public class ReqSiegeMoveMapMessage extends Message
    {

        public function ReqSiegeMoveMapMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 550108;
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
