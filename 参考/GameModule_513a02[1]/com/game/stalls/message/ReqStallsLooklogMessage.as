package com.game.stalls.message
{
    import net.*;

    public class ReqStallsLooklogMessage extends Message
    {

        public function ReqStallsLooklogMessage()
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
            return 123209;
        }// end function

    }
}
