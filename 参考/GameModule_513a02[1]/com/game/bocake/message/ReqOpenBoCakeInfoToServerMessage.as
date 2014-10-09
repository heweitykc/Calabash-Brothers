package com.game.bocake.message
{
    import net.*;

    public class ReqOpenBoCakeInfoToServerMessage extends Message
    {

        public function ReqOpenBoCakeInfoToServerMessage()
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
            return 529216;
        }// end function

    }
}
