package com.game.casting.message
{
    import net.*;

    public class ReqCastingDecomposeToServerMessage extends Message
    {

        public function ReqCastingDecomposeToServerMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 529204;
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
